require 'faraday'
require 'json'
require 'ostruct'

module BTCJam
	class EmploymentStatuses
		def self.all
			response = Faraday.get("#{API_PUBLIC_URL}/employment_statuses.json")
      attributes = JSON.parse(response.body).collect {|t| OpenStruct.new t }
		end
	end
end
