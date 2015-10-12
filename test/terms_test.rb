require './test/test_helper'

describe 'BTCJammer::Terms' do
  it 'should exist for sure' do
    assert BTCJammer::Terms
  end

  it 'should return a list of all supported terms' do
    VCR.use_cassette('terms') do
      terms = BTCJammer::Terms.all

      assert terms.is_a? Array
      assert terms.length == 6

      assert terms.first.id == 4
      assert terms.first.name == '1 Month'
      assert terms.first.short_term == true
      assert terms.first.term_days == 30
    end
  end
end
