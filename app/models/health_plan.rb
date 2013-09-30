class HealthPlan < ActiveRecord::Base

  has_many :to_dos,
    inverse_of: :health_plan

  has_many :user_health_plans

  has_many :users,
    through: :user_health_plans,
    dependent: :destroy

  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :plan_length_days
end
