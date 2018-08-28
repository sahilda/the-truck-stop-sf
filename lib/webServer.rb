# frozen_string_literal: true

require 'sinatra'
require_relative './slackAuth.rb'
require_relative './slackResponse.rb'

get '/' do
  'SF Trucks is running!'
end

post '/slack/trucks' do
  status 200
  p params
  command = params['command']
  text = params['text']
  if command == '/truck-stop'
    content_type 'application/json'
    body SlackResponse.build_response(:truck_stop, text)
  elsif command == '/parklab'
    content_type 'application/json'
    body SlackResponse.build_response(:parklab, text)
  end
end

get '/slack/auth' do
  status 200
  p params
  SlackAuth.get_access_token(params['code']) unless params['error'] == 'access_denied'
end
