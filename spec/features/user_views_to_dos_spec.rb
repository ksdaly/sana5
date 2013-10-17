require 'spec_helper'

feature 'user views to-dos', %Q{
  As a subscriber to a health plan
  I want to receive daily to-dos
  So that I can reach the goal of the health plan
} do

  # ACCEPTANCE CRITERIA
  # * I must have a valid health plan
  # * I can view a daily generated list of to-dos
  # * I can view to-dos for today
  # * I can only view to-dos assigned for myself
  # * I can submit to-dos as completed
  # * I can change completed status to incomplete
  # * I cannot access todos if they are not set up

  let(:user1) {FactoryGirl.create(:user)}
  let(:user2) {FactoryGirl.create(:user)}
  let!(:to_do_1) {FactoryGirl.create(:to_do)}
  let!(:to_do_2) {FactoryGirl.create(:to_do)}
  let!(:user_health_plan) {FactoryGirl.create(:user_health_plan, user: user1, health_plan: to_do_1.health_plan)}

  scenario 'user is able to view their to-dos' do
    user_to_do = FactoryGirl.create(:user_to_do, user: user1, to_do: to_do_1)
    sign_in_as(user1)
    visit user_to_dos_path
    expect(page).to have_content(to_do_1.title)
    expect(page).to have_content(Date.today)
  end

  scenario 'user is notified if there are no todos' do
    sign_in_as(user1)
    visit user_to_dos_path
    expect(page).to have_content("There are no current todos.")
  end

  scenario 'user is able to view only their own to-dos' do
    user_to_do = FactoryGirl.create(:user_to_do, user: user1, to_do: to_do_1)
    sign_in_as(user2)
    visit user_to_dos_path
    expect(page).to_not have_content(to_do_1.title)
  end

  scenario 'past to-dos are not displayed' do
    user_to_do_2 = FactoryGirl.create(:user_to_do, user: user1, to_do: to_do_2, day: Date.today - 1)
    sign_in_as(user1)
    visit user_to_dos_path
    expect(page).to_not have_content(to_do_2.title)
  end

  scenario 'future to-dos are not displayed' do
    user_to_do_3 = FactoryGirl.create(:user_to_do, user: user1, to_do: to_do_2, day: Date.today + 1)
    sign_in_as(user1)
    visit user_to_dos_path
    expect(page).to_not have_content(to_do_2.title)
  end

  scenario 'to-do is marked as completed' do
    user_to_do = FactoryGirl.create(:user_to_do, user: user1, to_do: to_do_1)
    sign_in_as(user1)
    visit user_to_dos_path
    check(to_do_1.title)
    click_on 'Update'
    user_to_do.reload
    expect(user_to_do.completed).to eql(true)
  end

  scenario 'completed to-do is marked as incomplete' do
    user_to_do = FactoryGirl.create(:user_to_do, user: user1, to_do: to_do_1, completed: true)
    sign_in_as(user1)
    visit user_to_dos_path
    uncheck(to_do_1.title)
    click_on 'Update'
    user_to_do.reload
    expect(user_to_do.completed).to eql(false)
  end
end
