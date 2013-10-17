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
    # ToDo.where(id: ToDo.pluck(:id).sample(5))
    ToDo.where(health_plan_id: self.health_plan.id)
  end

  def current_user_profile
    user = User.where("id=?", self.user_id).last
    profile = user.health_profiles.last
  end

  def get_nutrition_todos(todos)
    collection = []
    if current_user_profile.calculated_bmi < 25
      collection << todos.where(group: "nutrition", subgroup: "easy").sample(1)
    else
      collection << todos.where(group: "nutrition", subgroup: "challenging").sample(1)
    end
    collection
  end

  def get_activity_todos(todos)
    collection = []
    if current_user_profile.calculated_age < 45
      collection << todos.where(group: "activity", subgroup: "easy").sample(1)
    else
      collection << todos.where(group: "nutrition", subgroup: "challenging").sample(1)
    end
  end

  def get_wellness_todos(todos)
    collection = []
    if current_user_profile.male
      collection << todos.where(group: "wellness", subgroup: "male").sample(1)
    else
      collection << todos.where(group: "wellness", subgroup: "female").sample(1)
    end
    collection
  end


  def get_daily_todos
    todos = get_plan_todos
    collection = []
    collection << get_nutrition_todos(todos)
    collection << get_activity_todos(todos)
    collection << get_wellness_todos(todos)
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
