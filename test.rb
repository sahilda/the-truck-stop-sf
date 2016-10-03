require_relative 'dataPull'

d = DataPull.new
twitter_data = d.get_twitter_data
fb_html = d.get_fb_html(twitter_data)
fb_data = d.get_fb_data(fb_html)

p twitter_data
