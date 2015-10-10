require 'faraday'
require 'json'
require 'ostruct'
require 'oauth'

module BTCJam
	class Users
		private
		def self.get_client access_token
			client = OAuth2::Client.new ENV['BTCJAM_CLIENT_ID'], ENV['BTCJAM_CLIENT_SECRET'], :site => "https://btcjam.com"
			OAuth2::AccessToken.new client, access_token
		end

		def self.api_call access_token, symbol, type
			token = get_client access_token	
			response = token.get("#{API_URL}/#{symbol}.json")
      
			if type == :object
				OpenStruct.new JSON.parse(response.body)
			elsif type == :array
				JSON.parse(response.body).collect {|i| OpenStruct.new i}
			end
		end

		public
		def self.create(email, password)
			response = Faraday.post("#{API_URL}/users.json?appid=#{BTCJam.client_id}&secret=#{BTCJam.client_secret}", 
				{:email => email, :password => password})
      attributes = JSON.parse(response.body)
		end

		def self.profile access_token
			api_call(access_token, :me, :object)
		end

		def self.open_listings access_token
			api_call(access_token, :my_open_listings, :array)
		end
	end
end
