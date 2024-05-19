from flask_bcrypt import Bcrypt
from flask import Flask, jsonify, request
from pymongo import MongoClient

app = Flask(__name__)
bcrypt = Bcrypt(app)

client = MongoClient("mongodb://mongodb:27017/")
db = client.mydatabase




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
            db.users.update_one({'phone': data['phone']}, {'$set': {'contacts': user['contacts']}})
            return jsonify({"message": "Contact updated successfully"}), 200

    new_contact = {'name': data['contact_name'], 'phone': data['contact_phone']}
    db.users.update_one({'phone': data['phone']}, {'$push': {'contacts': new_contact}})
    return jsonify({"message": "Contact added successfully"}), 200


@app.route('/get_contacts', methods=['POST'])
def get_contacts():
    data = request.json
    email = data['email']
    user = db.users.find_one({'email': email})
    if user is None:
        return jsonify({"message": "User not found"}), 404
    return jsonify(user['contacts']), 200


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
