module OmniAuth
  module Strategies

    class SurveyMonkey
      include OmniAuth::Strategy

      configure url: 'https://www.surveymonkey.com/oauth/authorize'

      args [:client_id, :client_secret]

      def request_phase
        hash = { client_id: options.client_id, api_key: options.api_key, redirect_uri: callback_url, response_type: 'code' }.compact
        redirect "#{options.url}?#{hash.to_query}"
      end

      def callback_phase
        connection = ::Faraday.new url: 'https://api.surveymonkey.net' do |faraday|
          faraday.request  :url_encoded
          faraday.response :logger
          faraday.adapter  ::Faraday.default_adapter
        end

        form_fields = {
              client_id: options.client_id,
          client_secret: options.client_secret,
                   code: request.params['code'],
           redirect_uri: (full_host + callback_path),
             grant_type: 'authorization_code'
        }

        response = connection.post "/oauth/token#{"?api_key=#{options.api_key}" if options.api_key}", form_fields
        json = ::MultiJson.load response.body

        options.access_token = json['access_token']

        if options.access_token
          connection.authorization :Bearer, options.access_token
          info = connection.get "/v3/users/me?api_key=#{options.api_key}"
          json = ::MultiJson.load info.body

          options.account_type    = json['account_type']
          options.email           = json['email']
          options.email_verified  = json['email_verified']
          options.first_name      = json['first_name']
          options.surveymonkey_id = json['id'].to_i
          options.language        = json['language']
          options.last_name       = json['last_name']
          options.username        = json['username']
        end

        super
      end

      uid do
        options.surveymonkey_id
      end

      info do
        {
           account_type: options.account_type,
                  email: options.email
         email_verified: options.email_verified
             first_name: options.first_name,
              last_name: options.last_name,
               username: options.username,
               language: options.language,
        }
      end

      credentials do
        { token: options.access_token }
      end

    end
  end
end

OmniAuth.config.add_camelization 'surveymonkey', 'SurveyMonkey'
