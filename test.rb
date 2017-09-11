require './datapull.rb'

d = DataPull.new
d.parse_feed
p d.parse_post
