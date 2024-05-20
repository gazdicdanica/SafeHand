from flask_bcrypt import Bcrypt
from flask import Flask, jsonify, request
from pymongo import MongoClient
import firebase_admin
from firebase_admin import credentials, messaging
import lama

app = Flask(__name__)
bcrypt = Bcrypt(app)

client = MongoClient("mongodb://mongodb:27017/")
db = client.mydatabase

cred = credentials.Certificate("techsaysno-firebase-adminsdk-tnj21-d26f5188f5.json")
firebase_admin.initialize_app(cred)

def get_user_tokens(user):
    tokens = []
    phones = []
    for contact in user['contacts']:
        contact_user = db.users.find_one({'phone': contact['phone']})
        if contact_user is not None:
            tokens.append(contact_user['fcmToken'])
        else:
            phones.append(contact['phone'])
    return tokens, phones


@app.route('/alert', methods=['POST'])
def send_notification():
    data = request.json
    user = db.users.find_one({'email': data['email']})
    if user is None:
        return jsonify({"message": "User not found"}), 404
    latitude = data['latitude']
    longitude = data['longitude']
    address = "Novi Sad, Serbia"

    # Retrieve user tokens from the database
    tokens, phones = get_user_tokens(user)
    if not tokens:
        return jsonify({'error': 'No user tokens available'}), 400

    # Create the notification message
    message = messaging.MulticastMessage(
        data={
            'latitude': str(latitude),
            'longitude': str(longitude),
            'address': address
        },
        notification=messaging.Notification(
            title="Emergency Alert",
            body=f"User {user['name']} is in an emergency at {address}"
        ),
        tokens=tokens,
    )

    # Send the message to all user tokens
    response = messaging.send_multicast(message)
    return jsonify({
        'success': response.success_count,
        'failure': response.failure_count,
        'responses': [resp.message_id for resp in response.responses if resp.success]
    })


@app.route('/register', methods=['POST'])
def register():
    data = request.json
    existing_user = db.users.find_one({'$or': [{'email': data['email']}, {'phone': data['phone']}]})
    if existing_user is not None:
        return jsonify({"message": "Email or phone number already in use"}), 400
    hashed_password = bcrypt.generate_password_hash(data['password']).decode('utf-8')
    data['password'] = hashed_password
    data['contacts'] = []
    db.users.insert_one(data)
    return jsonify({"message": "User registered successfully"}), 200


@app.route('/login', methods=['POST'])
def login():
    data = request.json
    user = db.users.find_one({'email': data['email']})
    if user and bcrypt.check_password_hash(user['password'], data['password']):
        return jsonify({"message": "Login successful"}), 200
    else:
        return jsonify({"message": "Invalid email or password"}), 401


@app.route('/add_contact', methods=['POST'])
def add_contact():
    data = request.json
    user = db.users.find_one({'email': data['email']})
    if user is None:
        return jsonify({"message": "User not found"}), 404

    for contact in user['contacts']:
        if contact['phone'] == data['contact_phone']:
            contact['name'] = data['contact_name']
            db.users.update_one({'email': data['email']}, {'$set': {'contacts': user['contacts']}})
            return jsonify({"message": "Contact updated successfully"}), 200

    new_contact = {'name': data['contact_name'], 'phone': data['contact_phone']}
    db.users.update_one({'email': data['email']}, {'$push': {'contacts': new_contact}})
    return jsonify({"message": "Contact added successfully"}), 200


@app.route('/get_contacts', methods=['POST'])
def get_contacts():
    data = request.json
    email = data['email']
    user = db.users.find_one({'email': email})
    if user is None:
        return jsonify({"message": "User not found"}), 404
    return jsonify(user['contacts']), 200


@app.route('/get_response', methods=['POST'])
def get_lama_response():
    if request.is_json:
        try:
            user_data = request.json
            question = user_data.get("question")
            generalization_coefficient = None
            fromLlama = None

            if user_data.get("generalization_coefficient"):
                generalization_coefficient = user_data.get("generalization_coefficient")
                fromLlama = lama.answer_question(question, generalization_coefficient)
            else:
                fromLlama = lama.answer_question(question)

            flag, fromLlama = lama.get_content(fromLlama)

            return jsonify({
                "correct_json": flag,
                "answer": fromLlama, 
                }), 200
        

        except Exception as e:
            return jsonify({"error": str(e)}), 400
    else:
        return jsonify({"error": "Request body must be JSON"}), 400


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
