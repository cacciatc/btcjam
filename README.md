# Btcjam

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

If you want to ask more interesting things, then you'll need a BCTJam account and need (to register an app)[https://btcjam.com/oauth/applications] with BTCJam and grab your Application ID and Secret:

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

## Contributing

1. Fork it ( https://github.com/cacciatc/btcjam/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
