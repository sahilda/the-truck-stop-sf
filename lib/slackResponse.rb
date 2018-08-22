require_relative './dataPull.rb'
require 'json'

class SlackResponse
  def self.build_response
    response = {}
    response['response_type'] = 'in_channel'
    response['text'] = DataPull.new.get_trucks
    response.to_json
  end
end