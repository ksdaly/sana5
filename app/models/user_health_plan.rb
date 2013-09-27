class UserHealthPlan < ActiveRecord::Base

  belongs_to :user
  belongs_to :health_plan

  validates_presence_of :start_date

  def assign
    self.start_date = Date.today
    save
  end

  def self.options
    HealthPlan.all
  end

end
