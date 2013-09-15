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
    visit new_user_path
    fill_in "user_username", with: 'kate'
    fill_in "user_email", with: 'kate@example.com'
    click_button 'Sign up for Sana'
    expect(page).to have_content('Welcome to Sana!')
    expect(page).to have_content('kate')
  end

end
