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

    let!(:user1) {FactoryGirl.create(:user)}
    let(:health_profile) {FactoryGirl.create(:health_profile, user: user1)}
    let(:old_health_profile) {FactoryGirl.create(:health_profile, user: user1, updated_at: Time.now - 1.year )}

  scenario 'user creates health profile' do
    sign_in_as(user1)
    visit new_health_profile_path

    choose "health_profile_male_true"
    select "1984", from: "health_profile_dob_1i"
    select "April", from: "health_profile_dob_2i"
    select "12", from: "health_profile_dob_3i"
    fill_in "health_profile_weight", with: 135
    fill_in "health_profile_height", with: 67
    fill_in "health_profile_systolic_bp", with: 140
    fill_in "health_profile_diastolic_bp", with: 90
    click_button 'Submit'
    save_and_open_page
    expect(page).to have_content('1.88')
    expect(page).to have_content('1.1')
  end

 it 'user sees applicable errors' do
    visit new_health_profile_path
    sign_in_as(user1)

    click_button 'Submit'
    expect_presence_error_for(:weight)
  end

  scenario 'user edits health profile' do
    health_profile
    sign_in_as(user1)
    previous_count = HealthProfile.count
    visit edit_health_profile_path(health_profile)

    fill_in "health_profile_weight", with: 200
    click_button 'Submit'
    expect(HealthProfile.count).to eql(previous_count)
    expect(HealthProfile.last.weight).to eql(200)
    expect(HealthProfile.last.cardiovascular_risk).to_not be_nil
  end

  scenario 'user thinks they are editing health profile' do
    old_health_profile
    sign_in_as(user1)
    previous_count = HealthProfile.count
    visit edit_health_profile_path(old_health_profile)

    fill_in "health_profile_weight", with: 200
    click_button 'Submit'
    expect(HealthProfile.count).to eql(previous_count + 1)
    expect(HealthProfile.last.weight).to eql(200)
    expect(HealthProfile.last.cardiovascular_risk).to_not be_nil
  end

end

def expect_presence_error_for(attribute)
  within ".input.health_profile_#{attribute.to_s}" do
    expect(page).to have_content "can't be blank"
  end


end
