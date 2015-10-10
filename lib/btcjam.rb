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

module BTCJam
	API_URL = "https://btcjam.com/api/v1"
	API_PUBLIC_URL = "https://btcjam.com"

	module Configuration
		attr_accessor :client_id, :client_secret, :scopes, :redirect_uri
  
		def configure
			yield self
		end
	end

	class OAuth
		attr_reader :token
		def initialize
    	@client = OAuth2::Client.new(BTCJam.client_id, BTCJam.client_secret, :site => API_PUBLIC_URL)
		end
    
		def authorization_url(options)
			@client.auth_code.authorize_url(:redirect_uri => BTCJam.redirect_uri)
		end

    def get_access_token(code)
			@token = @client.auth_code.get_token(code, :redirect_uri => BTCJam.redirect_uri)
			@token
		end
	end

	extend Configuration
end
