require './test/test_helper'

describe "BTCJam::Users" do
	before do
		VCR.turn_off! :ignore_cassettes => true
		BTCJam.configure do |config|
			config.client_id 		 = "test_id"
			config.client_secret = "test_secret"
			config.redirect_uri  = "localhost/callback"
		end
	end

	after do
		VCR.turn_on!
	end

	it "should exist for sure" do
		assert BTCJam::Users
	end

	it "should support creating new users" do
		stub_request(:post, "https://btcjam.com/api/v1/users.json?appid=test_id&secret=test_secret").
			to_return(:body => {}.to_json)
		
		result = BTCJam::Users.create("test@example.com", "12345")
	end

	it "should support retrieving an authenticated user's profile" do
		stub_request(:get, "https://btcjam.com/api/v1/me.json").
			to_return(:body => {:id => 123, :email => "test@example.com"}.to_json)
		
		token = "12345"	
		profile = BTCJam::Users.profile token

		assert profile.id == 123
		assert profile.email == "test@example.com"
	end

	it "should support retrieving an authenticated user's open listings" do
		stub_request(:get, "https://btcjam.com/api/v1/my_open_listings.json").
			to_return(:body => [{:id => 123, :title => "Blarg"}].to_json)
		
		token = "12345"	
		listings = BTCJam::Users.open_listings token
		
		assert listings.class == Array
		assert listings.first.id == 123
		assert listings.first.title == "Blarg"
	end
end
