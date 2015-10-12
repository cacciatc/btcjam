require 'faraday'
require 'json'
require 'ostruct'

module BTCJammer
  # https://btcjam.com/faq/api
  class AutomaticPlanTemplates
    def self.all
      response = Faraday.get("#{API_PUBLIC_URL}/automatic_plan_templates.json")
      JSON.parse(response.body).collect { |t| OpenStruct.new t }
    end
  end
end
