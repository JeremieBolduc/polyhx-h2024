import base64
import json
import os
from http.client import HTTPException
from fastapi import FastAPI
from dotenv import load_dotenv
from fastapi.responses import JSONResponse
from bson.json_util import dumps, loads

from ImageClassificationModel import ImageClassificationModel
from GPTTextModel import GPTTextModel
from GPTVisionModel import GPTVisionModel
from ItemService import ItemService

app = FastAPI()

dotenv_path = os.path.join(os.path.dirname(__file__), '.venv', '.env')
load_dotenv(dotenv_path)
api_key = os.getenv("OPENAI_API_KEY")
db_connection_string = os.getenv("DB_CONNECTION_STRING")

image_classification_model = ImageClassificationModel()
vision_model = GPTVisionModel(api_key)
text_model = GPTTextModel()
item_service = ItemService(db_connection_string)


@app.get("/items")
async def get_items():
    items = item_service.get_all()
    # items_json = json.dumps(items, sort_keys=True, indent=4, default=json_util.default)

    json_string = dumps(items)
    return JSONResponse(json_string)

@app.post("/items")
async def create_item(payload: dict):
    try:
        base64_image = payload["image"]
        title = image_classification_model.infer(base64_image)
        message = vision_model.infer(base64_image)
        binary_image = base64.b64decode(base64_image)
        image_classification_model.infer(base64_image)
        item = {
            "image": binary_image,
            "title": title,
            "recommendation": message
        }
        item_service.insert(item)

        return message
    except KeyError:
        raise HTTPException(status_code=400, detail="Invalid JSON format. 'image' key is required.")
