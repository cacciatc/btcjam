require 'faraday'
require 'json'
require 'ostruct'

module BTCJam
  # https://btcjam.com/faq/api
  class Listings
    def self.all
      url = "#{API_URL}/"
      url += "listings.json?appid=#{BTCJam.client_id}&secret=#{BTCJam.client_secret}"
      response = Faraday.get(url)

      JSON.parse(response.body).collect do |c|
        listing = OpenStruct.new c['listing']
        listing.user = OpenStruct.new listing.user

        listing
      end
    end
  end
end
