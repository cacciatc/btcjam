require './test/test_helper'

describe 'BTCJammer::SubmitDocuments' do
  before do
    VCR.turn_off! ignore_cassettes: true
    BTCJammer.configure do |config|
      config.client_id = 'test_id'
      config.client_secret = 'test_secret'
      config.redirect_uri = 'localhost/callback'
    end
  end

  after do
    VCR.turn_on!
  end

  it 'should exist for sure' do
    assert BTCJammer::SubmitDocuments
  end

  it 'should support creating an identity check' do
    stub_request(:post, 'https://btcjam.com/api/v1/identity_checks.json')
      .with(body: { 'identity_check' => "{\"name\":\"Bob Sagat\",\"dob\":\"2015-01-01\",\"gender\":\"Male\",\"nationalid\":1,\"nationalid_type_id\":1,\"img\":\"\"}" },
            headers: { 'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization' => 'Bearer 1234', 'Content-Type' => 'application/x-www-form-urlencoded', 'User-Agent' => 'Faraday v0.9.2' })
      .to_return(status: 200, body: { identity_check: {} }.to_json, headers: {})

    token = '1234'
    params = {
      name: 'Bob Sagat',
      dob: '2015-01-01',
      gender: 'Male',
      nationalid: 1,
      nationalid_type_id: 1,
      img: ''
    }
    BTCJammer::SubmitDocuments.create_identity_check(token, params)
  end
end
