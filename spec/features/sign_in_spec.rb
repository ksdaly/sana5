require 'spec_helper'

feature 'user signs up', %Q{
  As a health concious person
  I want to sign up
  So that I can measure and reduce my health risks
  }, focus: true do

  # ACCEPTANCE CRITERIA
  # * I must specify a valid email address
  # * I must specify a valid username
  # * I must specify and confirm password
  # * If I don't provide the above, I get an error message
  # * If I specify valid information, I register my account and am authenticated


  scenario 'specifying valid and required information' do
    visit root_path
    click_on 'Sign up'
    fill_in 'user_username', with: 'ksdaly'
    fill_in 'user_email', with: 'kate@example.com'
    fill_in 'user_password', with: 12345678
    fill_in 'user_password_confirmation', with: 12345678
    click_button 'Sign up'
    expect(page).to have_content('Logged in as ksdaly')
    expect(page).to have_content('Logout')
  end

  scenario 'required information is not supplied' do
    visit root_path
    click_on 'Sign up'
    click_button 'Sign up'
    expect(page).to have_content('can\'t be blank')
    expect(page).to_not have_content('Logout')
  end

  scenario 'password confirmation does not match password' do
    visit root_path
    click_on 'Sign up'
    fill_in 'user_username', with: 'ksdaly'
    fill_in 'user_email', with: 'kate@example.com'
    fill_in 'user_password', with: 12345678
    fill_in 'user_password_confirmation', with: 87654321
    click_button 'Sign up'
    expect(page).to have_content('doesn\'t match')
    expect(page).to_not have_content('Logout')
  end

end

