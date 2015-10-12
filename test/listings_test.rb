require './test/test_helper'

describe 'BTCJammer::Listings' do
  before do
    BTCJammer.configure do |config|
      config.client_id     = 'test_id'
      config.client_secret = 'test_secret'
    end
    VCR.turn_off! ignore_cassettes: true
  end

  after do
    VCR.turn_on!
  end

  it 'should exist for sure' do
    assert BTCJammer::Listings
  end

  it 'should return a list of all open listings' do
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

    listings = BTCJammer::Listings.all

    assert listings.is_a? Array

    assert listings.first.id == 53_498
    assert listings.first.title == 'Debt. Reconsolidation'
    assert listings.first.term_days == 365
    assert listings.first.description == 'This should help me a lot.'
    assert listings.first.amount	== 11.1844
    assert listings.first.user.id	== 4022
  end

  it 'should allow an authenticated user to create a listing' do
    stub_request(:post, 'https://btcjam.com/api/v1/listings.json')
      .with(body: { "{\"loan_purpose_id\":1,\"currency_id\":2,\"amount\":0.01,\"term_days\":123,\"payment_type_id\":3,\"locale_id\":4,\"title\":\"A new listing\",\"description\":\"Sweet!\"}" => true },
            headers: { 'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization' => 'Bearer 12354', 'Content-Type' => 'application/x-www-form-urlencoded', 'User-Agent' => 'Faraday v0.9.2' })
      .to_return(status: 200, body: { listing: { success: true } }.to_json, headers: {})

    token = '12354'
    listing_params = {
      loan_purpose_id: 1,
      currency_id: 2,
      amount: 0.01,
      term_days: 123,
      payment_type_id: 3,
      locale_id: 4,
      title: 'A new listing',
      description: 'Sweet!'
    }
    response = BTCJammer::Listings.create token, listing_params

    assert response.success
  end
end
