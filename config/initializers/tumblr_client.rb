Tumblr.configure do |config|
  config.consumer_key = ENV['consumer_key']
  config.consumer_secret = ENV['consumer_secret']
  config.oauth_token = ENV['token']
  config.oauth_token_secret = ENV['token_secret']
end