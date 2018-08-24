# frozen_string_literal: true

require 'sinatra'
require_relative './slackResponse.rb'
require_relative './hipchatResponse.rb'

get '/' do
  'SF Truck Stop is running!'
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
