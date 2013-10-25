require "sinatra"
require "twitter"
require "instagram"

Twitter.configure do |config|
  config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
  config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
  config.oauth_token = ENV['TWITTER_OAUTH_TOKEN']
  config.oauth_token_secret = ENV['TWITTER_OAUTH_TOKEN_SECRET']
end

Instagram.configure do |config|
  config.client_id = ENV['INSTAGRAM_CLIENT_ID']
  config.client_secret = ENV['INSTAGRAM_CLIENT_SECRET']
end

get '/' do
  @tweets = Twitter.search('#forgecph').results
  # @feed.sort(&:source) TODO
  @grams = Instagram.tag_recent_media("forgecph")
  
  erb :wall
end