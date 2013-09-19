require 'spec_helper'


describe User do

  it {should have_many(:health_profiles)}
  it {should have_one(:health_plan).through(:user_health_plan)}
  it {should have_valid(:username).when('kate', 'kate_daly', 'kate007')}
  it {should_not have_valid(:username).when(nil, '', 'abcdefghijklmnop', 'kate.daly')}
  it {should have_valid(:email).when('kate@example.com')}
  it {should_not have_valid(:email).when(nil, '', 'kate')}
end

