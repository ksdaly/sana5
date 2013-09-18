require 'spec_helper'

feature 'user vists homepage', %Q{
  As a health concious person
  I want to have a tool that would help me stay healthy
  So that I can have a long and fulfilling life
} do

  # ACCEPTANCE CRITERIA
  # * unauthenticated user can visit Sana homepage
  # * unauthenticated user has an option to sign up
  # * unauthenticated user can't access any other part of the app

  scenario 'unauthenticated user has access to homepage' do
    visit root_path
    expect(page).to have_content('changes that matter')
  end

  scenario 'unauthenticated user has access to homepage' do
    visit root_path
    click_on 'Sign up'
    expect(current_path).to eql(new_user_registration_path)
  end

  scenario 'unauthenticated user has no access to non-homepage' do
    visit new_health_profile_path
    expect(current_path).to eql(new_user_session_path)
  end

end
