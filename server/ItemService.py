from pymongo import MongoClient


class ItemService:
    def __init__(self, connection_string):
        self.client = MongoClient(connection_string, tls=True, tlsAllowInvalidCertificates=True)
        self.db = self.client["dev"]
        self.collection = self.db["items"]

    def get_all(self):
        items = self.collection.find()

        return items

    def insert(self, data):
        self.collection.insert_one(data)