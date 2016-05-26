require 'oauth'
require './environment'

class TwitterConnector
	def initialize(screen_name)
		setup_request(screen_name)
		setup_http
		api_keys
	end

	def setup_request(screen_name)
		baseurl = "https://api.twitter.com"
		path = "/1.1/statuses/user_timeline.json"
		query = URI.encode_www_form("screen_name" => screen_name, "count" => 1)
		@address = URI("#{baseurl}#{path}?#{query}")
		@request = Net::HTTP::Get.new(@address.request_uri)
	end

	def setup_http
		@http = Net::HTTP.new(@address.host, @address.port)
		@http.use_ssl = true
		@http.verify_mode = OpenSSL::SSL::VERIFY_PEER
	end

	def api_keys
		@consumer_key = OAuth::Consumer.new(ENV['consumer_key1'], ENV['consumer_key2'])
		@access_token = OAuth::Token.new(ENV['access_token1'], ENV['access_token2'])
	end

	def get_response
		@request.oauth!(@http, @consumer_key, @access_token)
		@http.start
		@response = @http.request(@request)
	end
end

