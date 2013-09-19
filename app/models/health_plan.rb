class HealthPlan < ActiveRecord::Base

  has_many :user_health_plans

  has_many :users,
    through: :user_health_plans,
    dependent: :destroy

  validates_presence_of :title
  validates_presence_of :description
end
