require 'faraday'
require 'json'
require 'ostruct'

module BTCJam
	class Users
		def self.create(email, password)
			response = Faraday.post("#{API_URL}/users.json?appid=#{BTCJam.client_id}&secret=#{BTCJam.client_secret}", 
				{:email => email, :password => password})
      attributes = JSON.parse(response.body)
		end
	end
end
