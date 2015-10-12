require './test/test_helper'

describe 'BTCJammer::EmploymentStatuses' do
  it 'should exist for sure' do
    assert BTCJammer::EmploymentStatuses
  end

  it 'should return a list of all supported employment statuses' do
    VCR.use_cassette('employee_statuses') do
      statuses = BTCJammer::EmploymentStatuses.all

      assert statuses.is_a? Array
      assert statuses.length == 5

      assert statuses.first.id == 1
      assert statuses.first.name == 'Employee'
    end
  end
end
