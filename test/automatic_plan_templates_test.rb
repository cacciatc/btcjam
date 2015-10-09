require './test/test_helper'

describe "BTCJam::AutomaticPlanTemplates" do
	it "should exist for sure" do
		assert BTCJam::AutomaticPlanTemplates
	end

	it "should return a list of all supported automatic plan templates" do
		VCR.use_cassette('automatic_plan_templates') do
			templates = BTCJam::AutomaticPlanTemplates.all

			assert templates.kind_of? Array
			assert templates.length == 3

			assert templates.first.id == 1
			assert templates.first.name == "Conservative"
		end
	end
end
