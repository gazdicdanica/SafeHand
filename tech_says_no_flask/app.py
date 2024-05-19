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
    db.users.insert_one(data)
    return jsonify({"message": "User registered successfully"}), 201


@app.route('/login', methods=['POST'])
def login():
    data = request.json
    user = db.users.find_one({'email': data['email']})
    if user and bcrypt.check_password_hash(user['password'], data['password']):
        return jsonify({"message": "Login successful"}), 200
    else:
        return jsonify({"message": "Invalid email or password"}), 401


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
