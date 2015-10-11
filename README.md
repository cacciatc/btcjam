# btcjam

A Ruby interface to the BTCJam API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'btcjam'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install btcjam

## Usage

After installation and without further configuration you can use the following API methods:

```ruby
require 'btcjam'

# returns an array of currencies
BTCJam::Currencies.all

# returns an array of employment types
BTCJam::EmploymentTypes.all

# returns an array of national ID types
BTCJam::NationalIDTypes.all

# returns an array of payment types
BTCJam::PaymentTypes.all

# returns an array of automatic plan templates
BTCJam::AutomaticPlanTemplates.all
```

If you want to ask more interesting things, then you'll need a BCTJam account and need [to register an app](https://btcjam.com/oauth/applications) with BTCJam. Finally, grab your Application ID and Secret:

```ruby
require 'btcjam'

BTCJam.configure do |config|
	config.client_id     = "<YOUR APPLICATION ID>"
	config.client_secret = "<YOUR SECRET>"
end

# returns an array of listings (not sure yet if it is paginated and if so how)
BTCJam::Listings.all

# creates a new user (not very well tested currently)
BTCJam::Users.create "bilbo.baggins@shire.com", "Elevensies11"
```

Lastly, the following API methods require an authenticated user:

```ruby
require 'btcjam'
BTCJam.configure do |config|
	config.client_id     = "<YOUR APPLICATION ID>"
	config.client_secret = "<YOUR SECRET>"
	config.scopes				 = [:basic_profile, :extended_profile, :make_loan,
													:identity_information, :address_information, :income_information,
													:invest, :trade, :withdraw, :submit_documents, :manage_references]
	config.redirect_uri  = "<YOUR REGISTERED CALLBACK URL>"
end

# send the user here to authorize
auth = BTCJam::Oauth.new

url = auth.authorization_url

# assuming you get a code back
access_token = auth.get_access_token(code)

# retrieve the auth'd user's profile
BTCJam::Users.profile access_token.token

# retrieve the auth'd user's payables
BTCJam::Users.payables access_token.token

# retrieve the auth'd user's receivables
BTCJam::Users.receivables access_token.token

# retrieve the auth'd user's credit checks
BTCJam::Users.credit_checks access_token.token

# retrieve the auth'd user's addr checks
BTCJam::Users.addr_checks access_token.token

# retrieve the auth'd user's identity checks
BTCJam::Users.identity_checks access_token.token

# retrieve the auth'd user's open listings
BTCJam::Users.open_listings access_token.token
```

## Contributing

1. Fork it ( https://github.com/cacciatc/btcjam/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
