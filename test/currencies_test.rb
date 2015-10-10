require './test/test_helper'

describe 'BTCJam::Currencies' do
  it 'should exist for sure' do
    assert BTCJam::Currencies
  end

  it 'should return a list of all supported currencies' do
    VCR.use_cassette('currencies') do
      currencies = BTCJam::Currencies.all

      assert currencies.is_a? Array
      assert currencies.length == 7
      assert currencies.first.id == 1
      assert currencies.first.name == 'Bitcoin'
      assert currencies.first.conversion_to_btc == '1.0'
      assert currencies.first.conversion_from_btc == '1.0'
      assert currencies.first.iso_code == 'BTC'
      assert currencies.first.symbol == '฿'
      assert currencies.first.income_enabled == false
      assert currencies.first.combined_code == '฿ BTC'
      assert currencies.first.locale_code.nil?
      assert currencies.first.country_code.nil?
    end
  end
end
