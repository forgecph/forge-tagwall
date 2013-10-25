ENV["RACK_ENV"] ||= "development"

require "./show"
run Sinatra::Application