# frozen_string_literal: true

require_relative './dataPull.rb'

class TruckStopDataPull < DataPull
  def initialize
    super
    @feed = FacebookConnector.new.get_feed('TruckStopSF')
  end

  def parse_feed
    @feed.each do |post|
      if post['message'].include? 'TRUCKSTOP SF'
        @post = post['message']
        return @post
      end
    end
  end

  def parse_post
    @date = Time.now.getlocal('-08:00')

    if @date.sunday? || @date.saturday?
      data = "No trucks today. It's the weekend, go outside."
    else
      data = @post
      begin
        if @date.friday?
          data = data.slice(data.index(@@days[@date.wday])..-1)
        else
          data = data.slice(data.index(@@days[@date.wday])...data.index(@@days[@date.wday+1]))
        end
        data.gsub!("\n ","\n")
        data.gsub!(/[()]/, '(' => '', ')' => '')
        data.strip!
      rescue
        return "Too lazy to find out, look here yourself (honestly though, it's probably the case that *they* actually have been too lazy to update their menu online): https://www.facebook.com/TruckStopSF/ or https://lmgtfy.com/?q=Truck+Stop+SF." 
      end
    end

    return data
  end

  def enhance_data(data)
    data = data.split("\n")
    data.each_with_index do |val, idx|
      if idx.zero?
        data[idx] = "Today's (#{@date.strftime("%m/%d")}) trucks are:"
      elsif @@menu.key?(val.downcase.strip)
        data[idx] = "* #{val.strip} - #{@@menu[val.downcase.strip]}"
      else
        data[idx] << "* #{val.strip}"
      end
    end
    data.join("\n")
  end

  def get_trucks
    parse_feed
    data = parse_post
    if data == 'Too lazy to find out, look here yourself (honestly though, it\'s probably the case that *they* actually have been too lazy to update their menu online): https://www.facebook.com/TruckStopSF/ or https://lmgtfy.com/?q=Truck+Stop+SF.'
      return data
    end
    enhance_data(data)
  end
end
