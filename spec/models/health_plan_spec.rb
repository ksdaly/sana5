require 'spec_helper'

describe HealthPlan do

  it {should have_many(:users).through(:user_health_plans)}
  it {should have_many(:to_dos)}

  it {should have_valid(:title).when('string')}
  it {should_not have_valid(:title).when(nil, '')}
  it {should have_valid(:description).when('string')}
  it {should_not have_valid(:description).when(nil, '')}
  it {should have_valid(:plan_length_days).when(14, 21)}
  it {should_not have_valid(:plan_length_days).when(nil, '')}

end
