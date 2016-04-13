module OmniAuth
  module Strategies

    class SurveyMonkey
      include OmniAuth::Strategy

      configure url: 'https://www.surveymonkey.com/oauth/authorize'

      args [:client_id, :api_key, :client_secret]

      def request_phase
        hash = { client_id: options.client_id, api_key: options.api_key, redirect_uri: callback_url, response_type: 'code' }
        redirect "#{options.url}?#{hash.to_query}"
      end

      def callback_phase
        connection = Faraday.new url: 'https://api.surveymonkey.net' do |faraday|
          faraday.request  :url_encoded
          faraday.response :logger
          faraday.adapter  Faraday.default_adapter
        end

        form_fields = {
              client_id: options.client_id,
          client_secret: options.client_secret,
                   code: request.params['code'],
           redirect_uri: (full_host + callback_path),
             grant_type: 'authorization_code'
        }

        response = connection.post "/oauth/token?api_key=#{options.api_key}", form_fields
        json = MultiJson.load response.body
        options.access_token = json['access_token']

        connection.authorization :Bearer, options.access_token
        info = connection.get "/v3/users/me?api_key=#{options.api_key}"
        json = MultiJson.load info.body

        options.username        = json['username']
        options.first_name      = json['first_name']
        options.last_name       = json['last_name']
        options.account_type    = json['account_type']
        options.language        = json['language']
        options.email           = json['email']
        options.surveymonkey_id = json['id'].to_i

        super
      end

      uid do
        options.surveymonkey_id
      end

      info do
        {
           account_type: options.account_type,
             first_name: options.first_name,
              last_name: options.last_name,
               username: options.username,
               language: options.language,
                  email: options.email
        }
      end

      credentials do
        { token: options.access_token }
      end

    end
  end
end
