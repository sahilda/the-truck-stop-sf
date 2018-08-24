require 'koala'
require_relative './environment.rb'

class FacebookConnector
  def initialize
    get_token
    @graph = Koala::Facebook::API.new(@token)
  end

  def get_token
    oauth = Koala::Facebook::OAuth.new(ENV['app_id'], ENV['app_secret'], 'http://sahilda.com')
    @token = oauth.get_app_access_token
  end

  def get_feed(screen_name)
    @graph.get_connections(screen_name, "feed")
  end
end
