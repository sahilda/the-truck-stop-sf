# frozen_string_literal: true

require 'date'
require_relative './dataPull.rb'

class ParklabDataPull < DataPull
  def initialize
    super
    @feed = FacebookConnector.new.get_feed('ParklabJunction')
  end

  def parse_feed
    @feed.each do |post|
      if post['message'].include? 'FOOD TRUCK LANE'
        @post = post['message']
        return @post
      end
    end
  end

  def parse_post
    today = Time.now.getlocal('-08:00')
    begin
      @date = Date.parse(@post.scan(/^\D+[\s\d,]+/)[0].strip)
      if today.yday == @date.yday && today.year == @date.year
        @trucks = @post.scan(/Lunch.*/)[0][6..-1].split(",").map { |truck| truck.sub(/and/,'').strip }        
      end
    rescue
      return "Too lazy to find out, look here yourself (honestly though, it's probably the case that *they* actually have been too lazy to update their menu online): http://parklabjunction.com/ or https://lmgtfy.com/?q=parklab+junction."
    end
  end

  def enhance_data
    result = ["Today's (#{@date.strftime("%m/%d")}) trucks are:"]
    @trucks.each_with_index do | val, idx |
      if @@menu.key?(val.downcase.strip)
        result << "* #{val.strip} - #{@@menu[val.downcase.strip]}"
      else
        result << "* #{val.strip}"
      end
    end
    result.join("\n")
  end

  def get_trucks
    parse_feed
    data = parse_post
    if data == 'Too lazy to find out, look here yourself (honestly though, it\'s probably the case that *they* actually have been too lazy to update their menu online): http://parklabjunction.com/ or https://lmgtfy.com/?q=parklab+junction.'
      return data
    end
    enhance_data
  end
end
