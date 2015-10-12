require 'faraday'
require 'json'
require 'ostruct'

module BTCJammer
  # https://btcjam.com/faq/api
  class AutomaticPlans
    def self.create(access_token, params)
      token    = BTCJammer.get_client access_token
      response = token.post("#{API_URL}/automatic_plans.json", body: { automatic_plan: params.to_json })

      result = OpenStruct.new JSON.parse(response.body)
      OpenStruct.new(result.automatic_plan)
    end

    def self.all(access_token)
      token = BTCJammer.get_client access_token
      response = token.get("#{API_URL}/automatic_plans.json")

      result = OpenStruct.new JSON.parse(response.body)
      result.collect { |r| OpenStruct.new r }
    end
  end
end
