require 'net/https'
require 'json'
require 'uri'
require 'pg'
begin
  require_relative './environment.rb'
rescue LoadError
  p 'Using environment variables'
end

class SlackAuth
  @@uri = URI.parse("https://slack.com/api/oauth.access")
  @@con = PG.connect(ENV['DATABASE_URL'])

  def self.get_access_token(code)
    http = Net::HTTP.new(@@uri.host, @@uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(@@uri.request_uri)
    request.basic_auth ENV['slack_client_id'], ENV['slack_client_secret']
    request.set_form_data({"code" => code})
    response = http.request(request)
    p "Code: #{response.code}"
    # handle error code    
    if response.code != "200"
      return false
    end
    json = JSON.parse(response.body)
    p json
    if json.has_key?('ok') && (json['ok'] == 'false' || json['ok'] == false)      
      return false
    end
    SlackAuth.add_client(json['access_token'], json['team_name'], response.body)    
    true
  end

  def self.add_client(access_token, team_name, response)
    @@con.prepare('insert1', 'INSERT INTO slack_clients (access_token, team_name, response, active) VALUES ($1, $2, $3, $4);')
    @@con.exec_prepared('insert1', [access_token, team_name, response, true])
  end

  def self.get_clients
    @@con.exec("SELECT * FROM slack_clients;")
  end
end
