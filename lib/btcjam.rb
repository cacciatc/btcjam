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
		attr_accessor :client_id, :client_secret
  
		def configure
			yield self
		end
	end
	extend Configuration
end
