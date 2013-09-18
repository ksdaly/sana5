require 'spec_helper'

feature 'User creates health profile', %Q{
As a health concious person
I want to create a user profile
So that I can review my health risks
} do

# ACCEPTANCE CRITERIA
# * I must specify all valid information by filling out a form
# * If I don't specify valid information, I get an error
# * If I specify the required information, the information is recorded and my health risk evaluation is displayed

    let(:user1) {FactoryGirl.create(:user)}

  scenario 'user creates health profile' do
    visit new_health_profile_path
    sign_in_as(user1)

    choose "health_profile_male_true"
    select "1984", from: "health_profile_dob_1i"
    select "April", from: "health_profile_dob_2i"
    select "12", from: "health_profile_dob_3i"
    fill_in "health_profile_weight", with: 135
    fill_in "health_profile_height", with: 67
    fill_in "health_profile_systolic_bp", with: 140
    fill_in "health_profile_diastolic_bp", with: 90
    click_button 'Submit'

    expect(page).to have_content('1.88')
    expect(page).to have_content('1.1')
  end

end
