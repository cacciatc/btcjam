require './test/test_helper'

describe 'BTCJammer::NationalIDTypes' do
  it 'should exist for sure' do
    assert BTCJammer::NationalIDTypes
  end

  it 'should return a list of all supported national ID types' do
    VCR.use_cassette('national_id_types') do
      types = BTCJammer::NationalIDTypes.all

      assert types.is_a? Array
      assert types.length == 3

      assert types.first.id == 1
      assert types.first.name == "Driver's License"
      assert types.first.translated_name == "Driver's License"
    end
  end
end
