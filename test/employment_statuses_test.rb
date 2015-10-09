require './test/test_helper'

describe "BTCJam::EmploymentStatuses" do
	it "should exist for sure" do
		assert BTCJam::EmploymentStatuses
	end

	it "should return a list of all supported employment statuses" do
		VCR.use_cassette('employee_statuses') do
			statuses = BTCJam::EmploymentStatuses.all

			assert statuses.kind_of? Array
			assert statuses.length == 5

			assert statuses.first.id == 1
			assert statuses.first.name == "Employee"
		end
	end
end
