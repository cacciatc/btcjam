require 'faraday'
require 'json'
require 'ostruct'

module BTCJam
	class Listings
		def self.all
			response = Faraday.get("#{API_URL}/listings.json?appid=#{BTCJam.client_id}&secret=#{BTCJam.client_secret}")
      attributes = JSON.parse(response.body).collect do |c| 
				listing = OpenStruct.new c["listing"]
				listing.user = OpenStruct.new listing.user

				listing
			end
		end
	end
end
