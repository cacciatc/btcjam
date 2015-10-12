require './test/test_helper'

describe 'BTCJammer::AutomaticPlanTemplates' do
  it 'should exist for sure' do
    assert BTCJammer::AutomaticPlanTemplates
  end

  it 'should return a list of all supported automatic plan templates' do
    VCR.use_cassette('automatic_plan_templates') do
      templates = BTCJammer::AutomaticPlanTemplates.all

      assert templates.is_a? Array
      assert templates.length == 3

      assert templates.first.id == 1
      assert templates.first.name == 'Conservative'
    end
  end
end
