require 'faraday'
require 'json'
require 'ostruct'
require 'oauth'

module BTCJam
	class Users
		def self.create(email, password)
			response = Faraday.post("#{API_URL}/users.json?appid=#{BTCJam.client_id}&secret=#{BTCJam.client_secret}", 
				{:email => email, :password => password})
      attributes = JSON.parse(response.body)
		end

		def self.profile access_token
			client = OAuth2::Client.new ENV['BTCJAM_CLIENT_ID'], ENV['BTCJAM_CLIENT_SECRET'], :site => "https://btcjam.com"
			token  = OAuth2::AccessToken.new client, access_token
			
			response = token.get("#{API_URL}/me.json")
      
			OpenStruct.new JSON.parse(response.body)
		end
	end
end
