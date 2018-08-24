require_relative './truckStopDataPull.rb'
require_relative './parklabDataPull.rb'
require 'json'

class SlackResponse
  def self.build_response(type, text)
    response = {}
    response['response_type'] = 'in_channel'
    if type == :truck_stop
      if text == 'location'
        response['text'] = 'Location: https://goo.gl/maps/HJjYoF1yDnp'
      else
        response['text'] = TruckStopDataPull.new.get_trucks
      end
    elsif type == :parklab
      if text == 'location'
        response['text'] = 'Location: https://goo.gl/maps/E7NNxesniTw'
      else
        response['text'] = ParklabDataPull.new.get_trucks
      end
    end
    response.to_json
  end
end