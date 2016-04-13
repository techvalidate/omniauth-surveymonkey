# OmniAuth SurveyMonkey

This is the official OmniAuth strategy for authenticating to SurveyMonkey's v3 API. To use it, you'll need to sign up and create an app at the [SurveyMonkey Developer homepage](https://developer.surveymonkey.com/).

## Basic Usage
```
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :surveymonkey, ENV['SURVEYMONKEY_CLIENT_ID'], ENV['SURVEYMONKEY_API_KEY'], ENV['SURVEYMONKEY_SECRET']
end
```
