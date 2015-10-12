require 'ostruct'
require 'oauth2'

require_relative 'btcjammer/version'
require_relative 'btcjammer/currencies'
require_relative 'btcjammer/payment_types'
require_relative 'btcjammer/automatic_plan_templates'
require_relative 'btcjammer/employment_statuses'
require_relative 'btcjammer/national_id_types'
require_relative 'btcjammer/listings'
require_relative 'btcjammer/users'
require_relative 'btcjammer/terms'

# Contains all the BTCJam API magic
module BTCJammer
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
    attr_accessor :client
    def initialize
      @client = Client.new(BTCJam.client_id, BTCJam.client_secret,
                           site: API_PUBLIC_URL)
    end

    def authorization_url
      @client.auth_code.authorize_url(redirect_uri: BTCJam.redirect_uri,
                                      scope: BTCJam.scopes.join(' '))
    end

    def get_access_token(code)
      @client.auth_code.get_token(code, redirect_uri: BTCJam.redirect_uri)
    end

    def self.from_token(token)
      auth = OAuth.new
      OAuth2::AccessToken.new(auth.client, token)
    end
  end

  def self.get_client(access_token)
    id     = ENV['BTCJAM_CLIENT_ID']
    secret = ENV['BTCJAM_CLIENT_SECRET']
    client = OAuth2::Client.new id, secret, site: 'https://btcjam.com'

    OAuth2::AccessToken.new client, access_token
  end

  def self.api_call(access_token, symbol, type)
    token = get_client access_token
    response = token.get("#{API_URL}/#{symbol}.json")

    if type == :object
      OpenStruct.new JSON.parse(response.body)
    elsif type == :array
      JSON.parse(response.body).collect { |i| OpenStruct.new i }
    end
  end

  extend Configuration
end
