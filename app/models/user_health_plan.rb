class UserHealthPlan < ActiveRecord::Base

  belongs_to :user
  belongs_to :health_plan

  validates_presence_of :start_date

  def assign
    self.start_date = Date.today
    populate_user_todos
    save
  end

  def self.options
    HealthPlan.all
  end

  def get_plan_todos
    ToDo.where(health_plan_id: self.health_plan.id)
  end

  def current_user_profile
    user = User.where("id=?", self.user_id).last
    profile = user.health_profiles.last
  end

  def get_samples(todos, variable, limit, group, subgroup_one = "easy", subgroup_two = "challenging")
    collection = []
    if base_condition?(variable, limit)
      collection << todo_sample(todos, group, subgroup_one)
      else
      collection << todo_sample(todos, group, subgroup_two)
    end
    collection
  end

  def base_condition?(variable, limit)
    current_user_profile.send(variable) > limit
  end

  def todo_sample(todos, group, subgroup)
    todos.where(group: group, subgroup: subgroup).sample(2)
  end

  def get_daily_todos
    todos = get_plan_todos
    collection = []
    collection << get_samples(todos, :calculated_bmi, 25, "nutrition")
    collection << get_samples(todos, :calculated_age, 50, "activity")
    collection.flatten!
  end

  def plan_end_date
    self.start_date + self.health_plan.plan_length_days
  end

  def populate_user_todos
    date = self.start_date
    while date < plan_end_date
      get_daily_todos.each do |todo|
        user_todo = UserToDo.new
        user_todo.user_id = self.user_id
        user_todo.to_do_id = todo.id
        user_todo.day = date
        user_todo.save
      end
      date += 1
    end
  end

  def current_day
    Date.today - self.start_date
  end

  def pending_days
    self.plan_end_date - Date.today
  end

  def self.completion_array(user)
    array = []
    plan = UserHealthPlan.where(user_id: user.id).last
    array << plan.current_day
    array << plan.pending_days
  end

end
