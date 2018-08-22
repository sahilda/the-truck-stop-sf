require_relative '../lib/datapull.rb'

d = DataPull.new
p d.parse_feed
p d.parse_post
