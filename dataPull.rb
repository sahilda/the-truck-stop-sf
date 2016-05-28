require 'nokogiri'
require 'rest_client'
require 'json'
require './twitterConnector'

class DataPreparor
	def initialize
		@response = TwitterConnector.new("TruckStopSF").get_response
		@weekday = Time.now.getlocal('-08:00').wday
	end

	def get_twitter_data
		if @response.code == '200' then
  			tweet = JSON.parse(@response.body)
  			facebook_url = tweet[0]["entities"]["urls"][0]["expanded_url"]
			facebook_html = Nokogiri::HTML(RestClient.get(facebook_url))
			post_text = facebook_html.css("div").css(".hidden_elem")[1].to_s[/<p.+\/p>/]
			post_text.gsub!("<br />","\n")
			return text = Nokogiri::HTML.parse(post_text).text
		else
			return "ERROR: failed getting twitter data, response code: #{@response.code}."
		end
	end

	def get_trucks
		data = get_twitter_data
		if data.include?("ERROR")
			return data
		else
			text = parse_data(data)
			text = "There's no published data about Trucks yet..ugh this sucks." if text == nil
			text.gsub!("\n ","\n")
		end
		return text
	end

	def parse_data(data)
		if @weekday == 0 or @weekday == 6
			return "No trucks today. It's the weekend, go outside."
		else
			data.gsub!(/[()]/, '(' => '', ')' => '')
			case @weekday
			when 1
				return data[/MONDAY[\w\W]+TUESDAY/][0..-9]
			when 2
				return data[/TUESDAY[\w\W]+WEDNESDAY/][0..-11]
			when 3
				return data[/WEDNESDAY[\w\W]+THURSDAY/][0..-10]
			when 4
				return data[/THURSDAY[\w\W]+FRIDAY/][0..-8]
			when 5
				return data[/FRIDAY[\w\W]+/]
			end
		end
	end
end