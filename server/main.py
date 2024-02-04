import json
import os
from http.client import HTTPException
from fastapi import FastAPI
from dotenv import load_dotenv
from fastapi.responses import JSONResponse
from bson import json_util

from GPTTextModel import GPTTextModel
from GPTVisionModel import GPTVisionModel
from ItemService import ItemService

app = FastAPI()

dotenv_path = os.path.join(os.path.dirname(__file__), '.venv', '.env')
load_dotenv(dotenv_path)
api_key = os.getenv("OPENAI_API_KEY")
db_connection_string = os.getenv("DB_CONNECTION_STRING")

vision_model = GPTVisionModel(api_key)
text_model = GPTTextModel()
item_service = ItemService(db_connection_string)


@app.get("/items")
async def get_items():
    items = item_service.get_all()
    items_json = json.dumps(items, default=json_util.default)

    return JSONResponse(content=items_json)

@app.post("/items")
async def create_item(payload: dict):
    try:
        base64_image = payload["image"]
        message = vision_model.infer(base64_image)
        item = {
            "image": base64_image,
            "title": "some title",
            "recommendation": message
        }
        item_service.insert(item)

        return message
    except KeyError:
        raise HTTPException(status_code=400, detail="Invalid JSON format. 'image' key is required.")


@app.post("/text")
async def text(payload: dict):
    try:
        item_name = payload["text"]
        message = text_model.infer(item_name)

        return message
    except KeyError:
        raise HTTPException(status_code=400, detail="Invalid JSON format. 'item' key is required.")


@app.post("/more")
async def text(payload: dict):
    try:
        subject = payload["subject"]
        message = text_model.say_more(subject)

        return message
    except KeyError:
        raise HTTPException(status_code=400, detail="Invalid JSON format. 'item' key is required.")
