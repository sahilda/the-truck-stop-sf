require 'nokogiri'
require 'rest_client'
require 'json'
require_relative 'twitterConnector'

class DataPull
	def initialize
		@response = TwitterConnector.new("TruckStopSF").get_response
	end

	def get_twitter_data
		return JSON.parse(@response.body)
	end

	def get_fb_html(twitter_data)
		facebook_url = twitter_data[0]["entities"]["urls"][0]["expanded_url"]
		return Nokogiri::HTML(RestClient.get(facebook_url))
	end

	def get_fb_data(fb_html)
		return fb_html.css('code').children[0].to_xhtml.match(/<p>.*<\/p>/).to_s
	end

	def parse_fb_data(fb_data)
		date = Time.now.getlocal('-08:00')

		if date.wday == 0 or date.wday == 6
			data = "No trucks today. It's the weekend, go outside."
		else
			data = fb_data.split("<p>").select { | data | data.include?(date.strftime("%m/%d")) }[0]
			data = "Too lazy to get the info but it's really not that hard: https://lmgtfy.com/?q=Truck+Stop+SF." if data == nil

			data.gsub!("</p>","")
			data.gsub!("<br> ","\n")
			data.gsub!("<br /> ","\n")
			data.gsub!("\n ","\n")
			data.gsub!(/[()]/, '(' => '', ')' => '')
			data.strip!
		end

		return data
	end

	def get_truck
		if @response.code == '200' then
			twitter_data = get_twitter_data
			fb_html = get_fb_html(twitter_data)
			fb_data = get_fb_data(fb_html)
			data = parse_fb_data(fb_data)
		else
			data = "ERROR: failed getting twitter data, response code: #{@response.code}."
		end

		return data
	end
end