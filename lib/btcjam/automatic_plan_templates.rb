require 'faraday'
require 'json'
require 'ostruct'

module BTCJam
	class AutomaticPlanTemplates
		def self.all
			response = Faraday.get("#{API_PUBLIC_URL}/automatic_plan_templates.json")
      attributes = JSON.parse(response.body).collect {|t| OpenStruct.new t }
		end
	end
end
