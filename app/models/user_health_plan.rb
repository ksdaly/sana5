class UserHealthPlan < ActiveRecord::Base

  belongs_to :user
  belongs_to :health_plan
  has_many :user_to_dos

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

  def get_daily_todos
    get_plan_todos.sample(3)
  end

  def plan_end_date
    Date.today + self.health_plan.plan_length_days
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

end
