# btcjammer

A Ruby interface to the BTCJam API.

## Disclaimer

Note, investing with BTCJam involves risk. Use this API at your own risk.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'btcjammer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install btcjammer

## Usage

After installation and without further configuration you can use the following API methods:

```ruby
require 'btcjammer'

# returns an array of currencies
BTCJammer::Currencies.all

# returns an array of employment types
BTCJammer::EmploymentTypes.all

# returns an array of national ID types
BTCJammer::NationalIDTypes.all

# returns an array of payment types
BTCJammer::PaymentTypes.all

# returns an array of automatic plan templates
BTCJammer::AutomaticPlanTemplates.all
```

If you want to ask more interesting things, then you'll need a BCTJam account and need [to register an app](https://btcjam.com/oauth/applications) with BTCJam. Finally, grab your Application ID and Secret:

```ruby
require 'btcjammer'

BTCJammer.configure do |config|
	config.client_id     = "<YOUR APPLICATION ID>"
	config.client_secret = "<YOUR SECRET>"
end

# returns an array of listings (not sure yet if it is paginated and if so how)
BTCJammer::Listings.all

# creates a new user (not very well tested currently)
BTCJammer::Users.create "bilbo.baggins@shire.com", "Elevensies11"
```

Lastly, the following API methods require an authenticated user:

```ruby
require 'btcjammer'
BTCJammer.configure do |config|
	config.client_id     = "<YOUR APPLICATION ID>"
	config.client_secret = "<YOUR SECRET>"
	config.scopes				 = [:basic_profile, :extended_profile, :make_loan,
													:identity_information, :address_information, :income_information,
													:invest, :trade, :withdraw, :submit_documents, :manage_references]
	config.redirect_uri  = "<YOUR REGISTERED CALLBACK URL>"
end

# send the user here to authorize
auth = BTCJammer::OAuth.new

url = auth.authorization_url

# assuming you get a code back
code = "<CODE YOU RECEIVED IN CALLBACK>"
access_token = auth.get_access_token(code)

# or if you have a saved token
access_token = BTCJammer::OAuth.from_token token

# retrieve the auth'd user's profile
BTCJammer::Users.profile access_token.token

# retrieve the auth'd user's payables
BTCJammer::Users.payables access_token.token

# retrieve the auth'd user's receivables
BTCJammer::Users.receivables access_token.token

# retrieve the auth'd user's credit checks
BTCJammer::Users.credit_checks access_token.token

# retrieve the auth'd user's addr checks
BTCJammer::Users.addr_checks access_token.token

# retrieve the auth'd user's identity checks
BTCJammer::Users.identity_checks access_token.token

# retrieve the auth'd user's open listings
BTCJammer::Users.open_listings access_token.token

# invest in a listing
BTCJammer::User.invest access_token.token, {:listing_id => 123, :amount => 0.1}

# create a new listing
params = {
  loan_purpose_id: 1,
  currency_id: 2,
  amount: 0.01,
  term_days: 123,
  payment_type_id: 3,
  locale_id: 4,
  title: 'A new listing',
	description: 'Sweet!'
}
BTCJammer::Listings.create access_token.token, params
```

## Contributing

1. Fork it ( https://github.com/cacciatc/btcjammer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write tests
4. Run rubocop
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create a new Pull Request
