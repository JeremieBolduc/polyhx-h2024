from openai import OpenAI


class GPTTextModel:
    def __init__(self):
        self.client = OpenAI()
        self.preprompts = {
            "no_conv": "Don't answer like you're having a conversation with someone",
            "words_s": "Keep your response relatively small, about 100 words maximum.",
            "words_m": "Keep your response relatively small, about 200 words maximum.",
        }


    def infer(self, text):
      response = self.client.chat.completions.create(
        model="gpt-3.5-turbo-0125",
        messages=[
          {"role": "system", "content": "You are a helpful assistant."},
          {"role": "user", "content": f""""
            {self.preprompts["words_s"]}
            I want to know what I can do to use the object in the following text in terms 
            of sustainable development. I want to be able to recycle or reuse it if possible.
            Here's the text: {text}"""
           },
        ]
      )

      return response.choices[0].message.content

    def say_more(self, subject):
      response = self.client.chat.completions.create(
        model="gpt-3.5-turbo-0125",
        messages=[
          {"role": "system", "content": "You are a helpful assistant."},
          {"role": "assistant", "content": subject},
          {"role": "user", "content": f"""
              {self.preprompts["no_conv"]}
              {self.preprompts["words_m"]}
              Tell me more in terms of reusing, reducing, recycling and valuation (RRRV)
            """},
        ]
      )

      return response.choices[0].message.content