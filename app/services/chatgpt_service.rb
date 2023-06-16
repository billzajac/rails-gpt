# @note: This service is used to call the OpenAI API to generate a response to a message
# @note: The API key is stored in the credentials file
# @param message [String] The message to generate a response for
# @param model [String] The model to use for the response [gpt-3.5-turbo, gpt-3.5-turbo-0301, gpt-4]
# @param timeout [Integer] The timeout to set for the model. 10 is ok for gpt-3.5-turbo, but gpt-4 needs maybe 300 
# @return [String] The generated response
# @example
#   ChatgptService.call('What is your name?', 'gpt-4', 300 )
#   => "\n\nI am an AI language model created by OpenAI, so I don't have a name. You can call me OpenAI or AI assistant."
# API Docs: https://platform.openai.com/docs/api-reference/chat/create
class ChatgptService
  include HTTParty

  attr_reader :api_url, :options, :model, :timeout, :message

  def initialize(message, model = Rails.application.credentials.chatgpt_api_model, timeout = Rails.application.credentials.chatgpt_api_timeout)
    api_key = Rails.application.credentials.chatgpt_api_key
    @options = {
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{api_key}"
      }
    }
    @api_url = 'https://api.openai.com/v1/chat/completions'
    @model = model
    @timeout = model
    @message = message
  end

  def call
    body = {
      model:,
      messages: [{ role: 'user', content: message }]
    }
    response = HTTParty.post(api_url, body: body.to_json, headers: options[:headers], timeout: timeout)
    raise response['error']['message'] unless response.code == 200

    response['choices'][0]['message']['content']
  end

  class << self
    def call(message, model = Rails.application.credentials.chatgpt_api_model, timeout = Rails.application.credentials.chatgpt_api_timeout)
      new(message, model, timeout).call
    end
  end
end
