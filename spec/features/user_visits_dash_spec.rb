require 'spec_helper'

feature 'User visits dashboard', %Q{
  As a subsciber to a health plan
  I want to see my progress
  So that I know how my health has improved
} do

  # ACCEPTANCE CRITERIA
  # * I must have at least one health profile entry
  # * I must have a valid user health plan
  # * I can see current weight, BMI, blood pressure, cadiovascular risk, diabetes risk
  # * I can see difference between the innitial and current value for:
  #   weight, BMI, blood pressure, cadiovascular risk, diabetes risk


  scenario 'user is able to view dash' do
    @user = FactoryGirl.create(:user)
    user_health_plan = FactoryGirl.create(:user_health_plan, user: @user)
    innitial_health_profile = FactoryGirl.create(:health_profile, user: @user, created_at: Time.now - 1.day)
    @current_health_profile = FactoryGirl.create(:health_profile, user: @user, weight: 150 )

    sign_in_as(@user)
    visit health_profiles_path
    expect_current_health_profile_field
    expect_delta
  end
end

def expect_delta
  ["weight", "calculated_bmi", "systolic_bp", "diastolic_bp", "cardiovascular_risk", "diabetes_risk"].each do |variable|
    expect(page).to have_content(@user.health_profiles.delta(variable))
  end
end

def expect_current_health_profile_field
  [:weight, :calculated_bmi, :systolic_bp, :diastolic_bp, :cardiovascular_risk, :diabetes_risk].each do |variable|
    expect(page).to have_content(@current_health_profile.send(variable))
  end
end
