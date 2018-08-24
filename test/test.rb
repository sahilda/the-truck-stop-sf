require_relative '../lib/truckStopDataPull.rb'
require_relative '../lib/parklabDataPull.rb'

ts = TruckStopDataPull.new
p ts.parse_feed
p ts.parse_post

pl = ParklabDataPull.new
p pl.get_trucks
