require './test/test_helper'

describe 'BTCJammer::PaymentTypes' do
  it 'should exist for sure' do
    assert BTCJammer::PaymentTypes
  end

  it 'should return a list of all supported payment types' do
    VCR.use_cassette('payment_types') do
      types = BTCJammer::PaymentTypes.all

      assert types.is_a? Array
      assert types.length == 5

      assert types.first.id == 4
      assert types.first.name == '1st of the month'
      assert types.first.days_of_interval == 30
      assert types.first.enabled
      assert types.first.translated_name == '1st of the month'
    end
  end
end
