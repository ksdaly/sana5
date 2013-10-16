require 'spec_helper'

feature 'User cannot access landing page when signed in', %Q{
    As an athenticated user
    I donnot want to see the landing page
    So that I am not confused with the structure of the app
} do

  # ACCEPTANCE CRITERIA
  # * If I am not authenticated, I can visit the landing page
  # * If I am authenticated, I cannot visit the landing page and instead am redirected to daily checklist


  let!(:user) {FactoryGirl.create(:user)}

  scenario 'unauthenticated user visits root' do
    visit root_path
    expect(page).to have_content("Sign up for Sana")
  end

  scenario 'authenticated user visits root' do
    sign_in_as(user)
    visit root_path
    expect(page).to_not have_content("Sign up for Sana")
  end

  scenario 'signin and signout causes no root related errors' do
    visit root_path
    sign_in_as(user)
    visit root_path
    click_on 'Logout'
    expect(page).to have_content("Sign up for Sana")
  end
end
