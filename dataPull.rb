require './facebookConnector.rb'

class DataPull
	
	def initialize
		@feed = FacebookConnector.new.get_feed("TruckStopSF")
		make_days
	end

	def parse_feed
		@feed.each do | post |
			if post["message"].include? "TRUCKSTOP SF"
				@post = post["message"]
				break
			end
		end
	end

	def parse_post
		date = Time.now.getlocal('-08:00')

		if date.wday == 0 or date.wday == 6
			data = "No trucks today. It's the weekend, go outside."
		else
			data = @post
			if data == nil
				return "Too lazy to get the info but it's really not that hard: https://lmgtfy.com/?q=Truck+Stop+SF." 
			end
			if date.wday == 5 
				data = data.slice(data.index(@days[date.wday])..-1)
			else
				data = data.slice(data.index(@days[date.wday])...data.index(@days[date.wday+1]))
			end
			data.gsub!("\n ","\n")
			data.gsub!(/[()]/, '(' => '', ')' => '')
			data.strip!
		end

		return data
	end

	def make_days
		@days = {1=>"MONDAY", 2=>"TUESDAY", 3=>"WEDNESDAY", 4=>"THURSDAY", 5=>"FRIDAY"}
	end

	def get_trucks
		parse_feed
		return parse_post
	end

end