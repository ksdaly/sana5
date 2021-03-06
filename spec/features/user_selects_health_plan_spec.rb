require 'spec_helper'

feature 'User selects a health plan', %Q{
  As a registered user
  I want to chose a health plan
  So that I can have actionable to-dos to improve my health
} do

  # ACCEPTANCE CRITERIA
  # * I must have a valid health profile
  # * If I have a valid health profile, I can select a health plan
  # * If I select a health plan, a health plan is registered for me
  # * After a health plan is registered, a set of user todos are registered for me
  # * If I select a health plan, I get redirected to user todos
  # * If I have a health plan, I cannot create another one

  let(:user1) {FactoryGirl.create(:user)}
  let!(:health_profile1) {FactoryGirl.create(:health_profile, user: user1)}
  let!(:health_plan) {FactoryGirl.create(:health_plan)}

  scenario 'user selects a health plan' do
    sign_in_as(user1)
    visit new_user_health_plan_path
    click_on health_plan.title
    expect(page).to have_content('Health plan created!')
    expect(current_path).to eql(user_to_dos_path)
    expect(user1.user_to_dos).to_not eql(nil)
  end

  scenario "user can't create additional health plan through new action" do
    sign_in_as(user1)
    user_health_plan = FactoryGirl.create(:user_health_plan, user: user1)
    visit new_user_health_plan_path
    expect(current_path).to eql(user_health_plan_path(user_health_plan))
  end

end
