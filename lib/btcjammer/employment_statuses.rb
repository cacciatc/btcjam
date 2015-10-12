require 'faraday'
require 'json'
require 'ostruct'

module BTCJammer
  # https://btcjam.com/faq/api
  class EmploymentStatuses
    def self.all
      response = Faraday.get("#{API_PUBLIC_URL}/employment_statuses.json")
      JSON.parse(response.body).collect { |t| OpenStruct.new t }
    end
  end
end
