import requests

class GPTVisionModel():
    def __init__(self, api_key):
        self.api_key = api_key

    def infer(self, base64_image) -> str:
      headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {self.api_key}"
      }

      payload = {
        "model": "gpt-4-vision-preview",
        "messages": [
          {
            "role": "user",
            "content": [
              {
                "type": "text",
                "text": """
                    Don't identify the object in the image; I already know what it is. 
                    I want to know what I can do to use the object in the image in terms 
                    of sustainable development. I want to be able to recycle or reuse it if possible
                """
              },
              {
                "type": "image_url",
                "image_url": {
                  "url": f"data:image/jpeg;base64,{base64_image}"
                }
              }
            ]
          }
        ],
        "max_tokens": 300
      }

      response = requests.post("https://api.openai.com/v1/chat/completions", headers=headers, json=payload)
      json = response.json()

      return json['choices'][0]['message']['content']