require './test/test_helper'

describe 'BTCJam::Listings' do
  it 'should exist for sure' do
    assert BTCJam::Listings
  end

  it 'should return a list of all open listings' do
    VCR.turn_off! ignore_cassettes: true

    BTCJam.configure do |config|
      config.client_id = 'test_id'
      config.client_secret = 'test_secret'
    end
    stub_request(:get, 'https://btcjam.com/api/v1/listings.json?appid=test_id&secret=test_secret')
      .to_return(body: [
        {
          'listing' => {
            'id'	=> 53_498,
            'title' => 'Debt. Reconsolidation',
            'term_days'	=> 365,
            'description' => 'This should help me a lot.',
            'amount'	=> 11.1844,
            'user'	=> {
              'id' => 4022
            }
          }
        }
      ].to_json)

    listings = BTCJam::Listings.all

    assert listings.is_a? Array

    assert listings.first.id == 53_498
    assert listings.first.title == 'Debt. Reconsolidation'
    assert listings.first.term_days == 365
    assert listings.first.description == 'This should help me a lot.'
    assert listings.first.amount	== 11.1844
    assert listings.first.user.id	== 4022
    VCR.turn_on!
  end
end
