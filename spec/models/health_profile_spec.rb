require 'spec_helper'


describe HealthProfile do

  it {should belong_to(:user)}

  it {should have_valid(:dob).when('04/12/1984')}
  it {should have_valid(:weight).when(120, 98)}
  it {should_not have_valid(:weight).when(1, 1000, nil)}
  it {should have_valid(:height).when(67)}
  it {should_not have_valid(:height).when(1,100,nil)}
  it {should have_valid(:systolic_bp).when(80, 120, 180)}
  it {should_not have_valid(:systolic_bp).when(79, 181, nil)}
  it {should have_valid(:diastolic_bp).when(60, 85, 110)}
  it {should_not have_valid(:diastolic_bp).when(59, 111, nil)}
end
