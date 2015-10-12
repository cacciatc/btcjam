require 'faraday'
require 'json'
require 'ostruct'

module BTCJammer
  # https://btcjam.com/faq/api
  class Listings
    def self.all
      url = "#{API_URL}/"
      url += "listings.json?appid=#{BTCJammer.client_id}&"
      url += "secret=#{BTCJammer.client_secret}"

      response = Faraday.get(url)

      JSON.parse(response.body).collect do |c|
        listing = OpenStruct.new c['listing']
        listing.user = OpenStruct.new listing.user

        listing
      end
    end

    def self.create(access_token, params)
      token    = BTCJammer.get_client access_token
      response = token.post("#{API_URL}/listings.json", body: params.to_json)

      result = OpenStruct.new JSON.parse(response.body)
      OpenStruct.new(result.listing)
    end
  end
end
