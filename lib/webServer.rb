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
  if params['command'] == "/trucks"
    content_type 'application/json'
    body SlackResponse.build_response
  end
end
