require "sinatra"
require "twitter"
require "instagram"
require "fb_graph"

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

facebook = FbGraph::Application.new(ENV['FACEBOOK_APP_ID'], :secret => ENV['FACEBOOK_APP_SECRET'])

get '/' do
  @tweets = Twitter.search('#forgecph').results
  @grams = Instagram.tag_recent_media("forgecph")
  @faces = FbGraph::Searchable.search('#forgecph', access_token: facebook.get_access_token)
  
  erb :wall
end