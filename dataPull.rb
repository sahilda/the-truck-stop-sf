require './facebookConnector.rb'

class DataPull
	
	def initialize
		@feed = FacebookConnector.new.get_feed("TruckStopSF")
		make_days
		make_menu
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

	def enhance_data(data)
		data = data.split("\n")
		data.each_with_index do | val, idx |
			if idx == 0
				date = val[/\d+\/\d+/]
				data[idx] = "Today's (#{date}) Trucks are:"
			else
				if @menu.key?(val.downcase)
					data[idx] = "* #{val} - #{@menu[val.downcase]}"
				end
			end
		end
		return data.join("\n")
	end


	def make_days
		@days = {1=>"MONDAY", 2=>"TUESDAY", 3=>"WEDNESDAY", 4=>"THURSDAY", 5=>"FRIDAY"}
	end

	def make_menu
		@menu = {
			"whisk on wheels" => "http://www.sfwhisk.com/menu/",
			"the chairman" => "http://www.hailthechairman.com/sf-menu",
			"koja kitchen" => "http://www.kojakitchen.com/menu",
			"bonito poke" => "http://www.bonitopoke.com/menu.html",
			"hiyaaa" => "https://www.hiyaaa.net/menu",
			"curry up now" => "http://www.curryupnow.com/truck-menu/",
			"spork & stix" => "https://www.sporkandstix.com/menus",
			"drums and crumbs" => "http://drumsandcrumbs.com/drums-and-crumbs-menus/retail",
			"steamin' butger" => "http://www.thesteaminburger.com/menu.html",
			"steamin' burger" => "http://www.thesteaminburger.com/menu.html",
			"don pablo truck" => "http://www.donpablotrucksf.com/#menu",
			"phat thai" => "http://phatthaisf.com/menu.html",
			"an the go" => "https://twitter.com/anthegosf",
			"seoulful korean fried chicken" => "https://www.seoulfulfc.com/menu",
			"ebbett's good to go" => "https://ebbettsgoodtogo.com/",
			"mobowl" => "http://www.eatmobowl.com/menu.html",			
		}
	end

	def get_trucks
		parse_feed
		data = parse_post
		enhance_data(data)
	end

end