require 'ostruct'
require 'oauth2'

require_relative 'btcjam/version'
require_relative 'btcjam/currencies'
require_relative 'btcjam/payment_types'
require_relative 'btcjam/automatic_plan_templates'
require_relative 'btcjam/employment_statuses'
require_relative 'btcjam/national_id_types'
require_relative 'btcjam/listings'
require_relative 'btcjam/users'

# Contains all the BTCJam API magic
module BTCJam
  API_URL = 'https://btcjam.com/api/v1'
  API_PUBLIC_URL = 'https://btcjam.com'

  # Holds info for oauth config including BTCJam scopes
  module Configuration
    attr_accessor :client_id, :client_secret, :scopes, :redirect_uri

    def configure
      yield self
    end
  end

  # Helper methods around OAuth2
  class OAuth
    include OAuth2
    attr_reader :token
    def initialize
      @client = Client.new(BTCJam.client_id, BTCJam.client_secret,
                           site: API_PUBLIC_URL)
    end

    def authorization_url(_options)
      @client.auth_code.authorize_url(redirect_uri: BTCJam.redirect_uri)
    end

    def get_access_token(code)
      @client.auth_code.get_token(code, redirect_uri: BTCJam.redirect_uri)
    end
  end

  extend Configuration
end
