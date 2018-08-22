require_relative './dataPull.rb'
require 'json'

class HitchatResponse
  def self.build_response
    response = {}        
    response['color'] = 'green'
    response['message'] = DataPull.new.get_trucks
    response['notify'] = 'false'
    response['message_format'] = 'text'        
    response.to_json        
  end

  def build_server_response()
    auth_token = 'AklPfnySQeJNHZ2ATlUWJBT8wG2aJrIn3qzvVVPG'
    client_uri = 'https://xoom-eng.hipchat.com'
    room_id = '2300042'
    client_post = "/v2/room/#{room_id}/notification?auth_token=#{auth_token}"
  
    server_response = {}
    server_response['uri'] = client_uri
    server_response['post'] = client_post
    server_response['message'] = HitchatResponse.build_response
  
    server_response
  end
  
  def post_message_to_hipchat()
    server_response = build_server_response()
    uri = URI.parse(server_response['uri'])
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(server_response['post'])
    request.add_field('Content-Type', 'application/json')
    request.body = server_response['message']
    response = http.request(request)
  end
end