require './dataPull'

d = DataPreparor.new
p d.get_twitter_data
message = d.get_trucks
p message