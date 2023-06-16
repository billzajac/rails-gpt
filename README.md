# README

## Configure
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
