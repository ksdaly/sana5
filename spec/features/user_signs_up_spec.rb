require 'spec_helper'

feature 'User signs up', %Q{
As a health concious person
I want to sign up
So that I can measure and reduce my health risks
} do

# ACCEPTANCE CRITERIA
# * I must specify a valid username
# * I must specify a valid email address
# * If I don't provide the above, I get an error message
# * If I specify valid information, I register my account

  scenario 'user signs up' do
    visit new_user_registration_path
    fill_in "user_username", with: 'kate'
    fill_in "user_email", with: 'kate@example.com'
    fill_in "user_password", with: '12345678'
    fill_in "user_password_confirmation", with: '12345678'
    click_button 'Sign up'
    expect(page).to have_content('You have signed up successfully')
    expect(page).to have_content('kate')
    expect(page).to_not have_content('Sign up')
    expect(User.count).to eql(1)
  end

end
