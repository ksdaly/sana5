require 'spec_helper'

describe UserHealthPlan do

  it {should belong_to(:user)}
  it {should belong_to(:health_plan)}

  it {should have_valid(:user)}
  it {should have_valid(:health_plan)}

  it {should have_valid(:start_date).when( Date.today )}
  it {should_not have_valid(:start_date).when(nil, '')}

end

describe 'user to dos' do

  it 'populates user todos based on appropriate health plan' do
  end

end
