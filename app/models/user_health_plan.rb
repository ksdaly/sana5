class UserHealthPlan < ActiveRecord::Base

  belongs_to :user
  belongs_to :health_plan

  def self.options
    HealthPlan.all
  end

end
