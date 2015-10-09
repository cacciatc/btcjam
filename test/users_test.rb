require './test/test_helper'

describe "BTCJam::Users" do
	it "should exist for sure" do
		assert BTCJam::Users
	end

	it "should support creating new users" do
		VCR.turn_off! :ignore_cassettes => true

		BTCJam.configure do |config|
			config.client_id 		 = "test_id"
			config.client_secret = "test_secret"
		end

		stub_request(:post, "https://btcjam.com/api/v1/users.json?appid=test_id&secret=test_secret".
			to_return(:body => {})
		
		result = BTCJam::Users.create "test@example.com", "12345"

		assert result
		VCR.turn_on!		
	end
end
