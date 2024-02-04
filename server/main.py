import os
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
async def upload_file(payload: dict):
    base64_image = payload["image"]
    message = vision_model.infer(base64_image)

    return message

@app.post("/item")
async def text(payload: dict):
    item_name = payload["item"]
    message = text_model.infer(item_name)

    return message

@app.post("/more")
async def text(payload: dict):
    subject = payload["subject"]
    message = text_model.say_more(subject)

    return message