require 'socket'
require 'json'
require 'net/http'
require 'openssl'
require './dataPull'

server = TCPServer.new 50001

def build_chat_response
	dataPull = DataPull.new
	message = dataPull.get_truck

	response = {}
	response["color"] = "green"
	response["message"] = message
	response["notify"] = "false"
	response["message_format"] = "text"

	return response.to_json
end

def build_server_response(client_data)
	client_data_hash = JSON.parse(client_data)
	room_id = client_data_hash["item"]["room"]["id"]
	auth_token = "AklPfnySQeJNHZ2ATlUWJBT8wG2aJrIn3qzvVVPG"
	client_uri = "https://xoom-eng.hipchat.com"
	client_post = "/v2/room/#{room_id}/notification?auth_token=#{auth_token}"

	server_response = {}
	server_response["uri"] = client_uri
	server_response["post"] = client_post
	server_response["message"] = build_chat_response

	return server_response
end

def post_message_to_hipchat(client_data)
	server_response = build_server_response(client_data)
	uri = URI.parse(server_response["uri"])
	http = Net::HTTP.new(uri.host, uri.port)
	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	request = Net::HTTP::Post.new(server_response["post"])
	request.add_field('Content-Type', 'application/json')
	request.body = server_response["message"]
	response = http.request(request)
end

loop do 
	client = server.accept

  	headers = {}
  	while line = client.gets.split(" ", 2)
    	break if line[0] == ""
    	headers[line[0].chop] = line[1].strip
  	end

  	STDERR.puts headers

	client_data = client.read(headers["Content-Length"].to_i)
	post_message_to_hipchat(client_data)

	client.close
end