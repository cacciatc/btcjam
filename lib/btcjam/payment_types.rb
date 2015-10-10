require 'faraday'
require 'json'
require 'ostruct'

module BTCJam
  # https://btcjam.com/faq/api
  class PaymentTypes
    def self.all
      response = Faraday.get("#{API_PUBLIC_URL}/payment_types.json")
      JSON.parse(response.body).collect { |t| OpenStruct.new t }
    end
  end
end
