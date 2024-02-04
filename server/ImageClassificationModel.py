from transformers import AutoImageProcessor, BitForImageClassification
import torch
from PIL import Image
import base64
from io import BytesIO


class ImageClassificationModel:
    def __init__(self):
        self.image_processor = AutoImageProcessor.from_pretrained("google/bit-50")
        self.model = BitForImageClassification.from_pretrained("google/bit-50")

    def base64_to_image(self, base64_string):
        # Remove the header if it exists (e.g., 'data:image/png;base64,')
        base64_string = base64_string.split(',')[1] if ',' in base64_string else base64_string

        # Decode the base64 string
        image_data = base64.b64decode(base64_string)

        # Create a BytesIO object to read the image
        image_buffer = BytesIO(image_data)

        # Open the image using PIL (Pillow)
        image = Image.open(image_buffer)

        return image

    def infer(self, base64_image: str):
        image = self.base64_to_image(base64_image)
        inputs = self.image_processor(image, return_tensors="pt")

        with torch.no_grad():
            logits = self.model(**inputs).logits

        predicted_label = logits.argmax(-1).item()
        return self.model.config.id2label[predicted_label]