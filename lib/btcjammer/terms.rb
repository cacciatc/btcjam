require 'faraday'
require 'json'
require 'ostruct'

module BTCJammer
  # No official docs, this method is alluded to.
  class Terms
    def self.all
      response = Faraday.get("#{API_PUBLIC_URL}/terms.json")
      JSON.parse(response.body).collect { |t| OpenStruct.new t }
    end
  end
end
