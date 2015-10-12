require 'faraday'
require 'json'
require 'ostruct'

module BTCJammer
  # https://btcjam.com/faq/api
  class NationalIDTypes
    def self.all
      response = Faraday.get("#{API_PUBLIC_URL}/nationalid_types.json")
      JSON.parse(response.body).collect { |t| OpenStruct.new t }
    end
  end
end
