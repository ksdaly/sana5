require 'spec_helper'

feature 'user views to-dos', %Q{
  As a subscriber to a health plan
  I want to receive daily to-dos
  So that I can reach the goal of the health plan
}, focus: true do

  # ACCEPTANCE CRITERIA
  # * I must have a valid health plan
  # * I  can view a daily generated list of to-dos
  # * I can view to-dos for today

  let(:user1) {FactoryGirl.create(:user)}
  let(:user2) {FactoryGirl.create(:user)}
  let!(:to_do) {FactoryGirl.create(:to_do)}
  let!(:user_health_plan) {FactoryGirl.create(:user_health_plan, user: user1, health_plan: to_do.health_plan)}
  let!(:user_to_do) {FactoryGirl.create(:user_to_do, user: user1, to_do: to_do)}

  scenario 'user is able to view to-dos' do
    sign_in_as(user1)
    visit user_to_dos_path
    expect(page).to have_content(to_do.title)
  end


  scenario 'user is able to view only their own to-dos' do
    sign_in_as(user2)
    visit user_to_dos_path
    expect(page).to_not have_content(to_do.title)
  end
end
