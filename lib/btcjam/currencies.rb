require 'faraday'
require 'json'
require 'ostruct'

module BTCJam
  # https://btcjam.com/faq/api
  class Currencies
    def self.all
      response = Faraday.get("#{API_PUBLIC_URL}/currencies.json")
      JSON.parse(response.body).collect { |c| OpenStruct.new c }
    end
  end
end
