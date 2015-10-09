require 'faraday'
require 'json'
require 'ostruct'

module BTCJam
	class NationalIDTypes
		def self.all
			response = Faraday.get("#{API_PUBLIC_URL}/nationalid_types.json")
      attributes = JSON.parse(response.body).collect {|t| OpenStruct.new t }
		end
	end
end
