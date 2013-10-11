require 'spec_helper'


describe HealthProfile do

  it {should belong_to(:user)}

  it {should have_valid(:user)}

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

describe 'calculate_risks' do
  it 'updates health profile with cardiovascular risk and diabetes risk' do
    health_profile = FactoryGirl.create(:health_profile, cardiovascular_risk: nil, diabetes_risk: nil)
    health_profile.calculate_risks
    expect(health_profile.cardiovascular_risk).to_not eql(nil)
    expect(health_profile.diabetes_risk).to_not eql(nil)
  end
end


describe 'cardiovascular_risk_calculation' do
  it 'calculates cardiovascular risk' do
    health_profile = FactoryGirl.create(:health_profile, cardiovascular_risk: nil)
    expect(health_profile.cardiovascular_risk_calculation).to eql(1.34)
  end
end


describe 'diabetes_risk_calculation' do
  it 'calculates cardiovascular risk' do
    health_profile = FactoryGirl.create(:health_profile, diabetes_risk: nil)
    expect(health_profile.diabetes_risk_calculation).to eql(0.46)
  end
end

describe 'calculated_bmi' do
  it 'calculates bmi' do
    health_profile = FactoryGirl.create(:health_profile)
    expect(health_profile.calculated_bmi).to eql(21.93)
  end
end

describe 'calculated_age' do
  it 'calculates age' do
    health_profile = FactoryGirl.create(:health_profile)
    expect(health_profile.calculated_age).to eql(29)
  end
end

describe 'returns variable diff for first and last health profile' do
  it 'returns delta' do
    innitial_health_profile = FactoryGirl.create(:health_profile, created_at: Time.now - 1.day)
    current_health_profile = FactoryGirl.create(:health_profile, weight: 150)

    expect(HealthProfile.delta("weight")).to eql(10)
    expect(HealthProfile.delta("cardiovascular_risk")).to eql(0)
  end
end

describe 'returns risk array for charts' do
  it 'returns an array of risks and dates for given user and risk argument' do
    health_profile_1 = FactoryGirl.create(:health_profile, created_at: Time.now - 1.day)
    health_profile_2 = FactoryGirl.create(:health_profile, created_at: Time.now, user: health_profile_1.user)

    expect(HealthProfile.risk_array(health_profile_1.user, "cardiovascular_risk")).to eql([[health_profile_1.js_date, health_profile_1.cardiovascular_risk.to_f], [health_profile_2.js_date, health_profile_2.cardiovascular_risk.to_f]])
  end

  it 'returns corect date format for JavaScript' do
    health_profile = FactoryGirl.create(:health_profile)
    expect(health_profile.js_date).to eql(health_profile.created_at.beginning_of_day.to_i * 1000)
  end
end
