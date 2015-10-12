require 'faraday'
require 'json'
require 'ostruct'

module BTCJammer
  # https://btcjam.com/faq/api
  class SubmitDocuments
    def self.create_identity_check(access_token, params)
      token    = BTCJammer.get_client access_token
      response = token.post("#{API_URL}/identity_checks.json", body: { identity_check: params.to_json })

      result = OpenStruct.new JSON.parse(response.body)
      OpenStruct.new(result.identity_check)
    end

    def self.create_addr_check(access_token, params)
      token = BTCJammer.get_client access_token
      response = token.post("#{API_URL}/addr_checks.json", body: { addr_checks: params.to_json })

      result = OpenStruct.new JSON.parse(response.body)
      OpenStruct.new(result.addr_check)
    end

    def self.create_credit_check(access_token, params)
      token = BTCJammer.get_client access_token
      response = token.post("#{API_URL}/credit_checks.json", body: { credit_checks: params.to_json })

      result = OpenStruct.new JSON.parse(response.body)
      OpenStruct.new(result.credit_check)
    end
  end
end
