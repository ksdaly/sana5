require 'spec_helper'

describe UserHealthPlan do

  it {should belong_to(:user)}
  it {should belong_to(:health_plan)}

  it {should have_valid(:user)}
  it {should have_valid(:health_plan)}

  it {should have_valid(:start_date).when( Date.today )}
  it {should_not have_valid(:start_date).when(nil, '')}

end

describe 'user to dos' do

  it 'populates user todos based on appropriate health plan' do
    user_health_plan = FactoryGirl.create(:user_health_plan)
    to_do_1 = FactoryGirl.create(:to_do, health_plan: user_health_plan.health_plan)
    to_do_2 = FactoryGirl.create(:to_do)
    user = user_health_plan.user
    user_health_profile = FactoryGirl.create(:health_profile, user: user)
    user_health_plan.populate_user_todos


    expect(user.user_to_dos).to_not eql(nil)
    expect(user.user_to_dos).to_not include(UserToDo.where(to_do_id: to_do_2.id))
  end

  it 'populates user todos with day unique todos' do
    user_health_plan = FactoryGirl.create(:user_health_plan)
    to_dos = FactoryGirl.create_list(:to_do, 10, health_plan: user_health_plan.health_plan)
    user = user_health_plan.user
    user_health_profile = FactoryGirl.create(:health_profile, user: user)
    user_health_plan.populate_user_todos
    current_todos = UserToDo.where(user: user, day: Date.today)

    expect(current_todos.uniq.count).to eql(current_todos.count)
  end

  it 'populates todos for the duration of user_health_plan' do
    user_health_plan = FactoryGirl.create(:user_health_plan)
    to_do_1 = FactoryGirl.create(:to_do, health_plan: user_health_plan.health_plan, subgroup: "challenging")
    user = user_health_plan.user
    user_health_profile = FactoryGirl.create(:health_profile, user: user)
    user_health_plan.populate_user_todos
    plan_length = user_health_plan.health_plan.plan_length_days

    expect(user.user_to_dos.count).to eql(plan_length)
    expect(user.user_to_dos.first.day).to eql(Date.today)
    expect(user.user_to_dos.last.day).to eql(Date.today + (plan_length - 1))
  end

  it 'populates todos with the appropriate number each day' do
    user_health_plan = FactoryGirl.create(:user_health_plan)
    to_dos = FactoryGirl.create_list(:to_do, 10, health_plan: user_health_plan.health_plan)
    user = user_health_plan.user
    user_health_profile = FactoryGirl.create(:health_profile, user: user)
    user_health_plan.populate_user_todos
    plan_length = user_health_plan.health_plan.plan_length_days

    expect(user.user_to_dos.count).to eql(user_health_plan.get_daily_todos.count * plan_length)
  end

  it 'populates todos according to bmi' do
    user_health_plan = FactoryGirl.create(:user_health_plan)
    to_do_1 = FactoryGirl.create(:to_do, health_plan: user_health_plan.health_plan, subgroup: "challenging")
    to_do_2 = FactoryGirl.create(:to_do, health_plan: user_health_plan.health_plan, subgroup: "easy")
    user = user_health_plan.user
    user_health_profile = FactoryGirl.create(:health_profile, user: user)
    user_health_plan.populate_user_todos

    expect(user.user_to_dos).to_not eql(nil)
    expect(user.user_to_dos).to_not include(UserToDo.where(to_do_id: to_do_2.id))
  end

  it 'populates todos according to age' do
    user_health_plan = FactoryGirl.create(:user_health_plan)
    to_do_1 = FactoryGirl.create(:to_do, health_plan: user_health_plan.health_plan, group: "activity", subgroup: "challenging")
    to_do_2 = FactoryGirl.create(:to_do, health_plan: user_health_plan.health_plan, group: "activity", subgroup: "easy")
    user = user_health_plan.user
    user_health_profile = FactoryGirl.create(:health_profile, user: user)
    user_health_plan.populate_user_todos

    expect(user.user_to_dos).to_not eql(nil)
    expect(user.user_to_dos).to_not include(UserToDo.where(to_do_id: to_do_2.id))
  end

end

describe 'returns completion array for charts for a given user' do
  it 'returns an array of completed and pending days' do
    user_health_plan = FactoryGirl.create(:user_health_plan, start_date: Date.today - 1.day)
    user = user_health_plan.user
    current_day = user_health_plan.current_day
    pending_days = user_health_plan.pending_days

    expect(UserHealthPlan.completion_array(user)).to eql([current_day, pending_days])
  end
end
