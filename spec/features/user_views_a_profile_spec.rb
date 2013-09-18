require 'spec_helper'

feature 'user views a profiel', %Q{
  As a person concerned with privacy
  I want to be the only one who can access my profile
  So that my health data remains secure
}, focus: true do

# ACCEPTANCE CRITERIA
# * Only the user owning the health profile can view or edit the health profile
# * An unauthenticated user can not create or access any health profiles and is redirected to signup/login

  let(:user1) {FactoryGirl.create(:user)}
  let(:user2) {FactoryGirl.create(:user)}
  let!(:health_profile1) {FactoryGirl.create(:health_profile, user: user1)}

  scenario 'unauthenticated user is able to view a health profile' do
    visit health_profile_path(user1.health_profiles.first)
    expect(page).to have_content("You need to sign in or sign up before continuing")
  end

  scenario 'user is able to view a health profile' do
    sign_in_as(user1)
    visit health_profile_path(user1.health_profiles.first)
    expect(page).to have_content("profile for #{user1.username}")
  end

  scenario 'user is unable to view a health profile' do
    sign_in_as(user2)
    visit health_profile_path(user1.health_profiles.first)
    expect(page).to have_content("Access Denied")
  end

end
