import os
from http.client import HTTPException
from fastapi import FastAPI
from dotenv import load_dotenv

from GPTTextModel import GPTTextModel
from GPTVisionModel import GPTVisionModel

app = FastAPI()

dotenv_path = os.path.join(os.path.dirname(__file__), '.venv', '.env')
load_dotenv(dotenv_path)
api_key = os.getenv("OPENAI_API_KEY")

vision_model = GPTVisionModel(api_key)
text_model = GPTTextModel()

@app.post("/image")
async def image(payload: dict):
    try:
        base64_image = payload["image"]
        message = vision_model.infer(base64_image)

        return message
    except KeyError:
        raise HTTPException(status_code=400, detail="Invalid JSON format. 'image' key is required.")

@app.post("/item")
async def item(payload: dict):
    try:
        item_name = payload["item"]
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