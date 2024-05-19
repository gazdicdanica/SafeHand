from flask import Flask, jsonify, request
from pymongo import MongoClient

app = Flask(__name__)

client = MongoClient("mongodb://mongo:27017/")
db = client.mydatabase

@app.route('/')
def hello_world():
    return 'Hello, World!'

@app.route('/add', methods=['POST'])
def add_document():
    data = request.json
    result = db.mycollection.insert_one(data)
    return jsonify({"_id": str(result.inserted_id)}), 201

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
