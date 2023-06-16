# README

This is a super simple rails project that will send requests to the ChatGPT API
The magic all happens in app/services/chatgpt_service.rb which uses httparty to call the API

## Configure

* Set your API key, default model, and timeout in the credentials file

```
EDITOR="vim" bin/rails credentials:edit
```

* Note: gpt-4 will require a much larger timeout

```
chatgpt_api_key: YOUR_KEY
chatgpt_api_model: gpt-3.5-turbo
chatgpt_api_timeout: 10
```

## Usage

```
rails c

response = ChatgptService.call("tell me something interesting about spiders", "gpt-4", 300)
```
