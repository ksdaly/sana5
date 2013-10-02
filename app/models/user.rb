class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :health_profiles,
    inverse_of: :user,
    dependent: :destroy

  has_one :user_health_plan

  # PDP thinks you don't want this
  has_one :health_plan,
    through: :user_health_plan,
    dependent: :destroy

  has_many :user_to_dos, dependent: :destroy

  # PDP thinks you don't want this either
  has_many :to_dos,
    through: :user_to_dos,
    dependent: :destroy

  validates_presence_of :username
  validates_uniqueness_of :username
  validates_format_of :username, with: /\A[A-Za-z0-9_]{1,15}\z/i

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/

  def add_health_plan(health_plan_id)
    # create a new UserHealthPlan record
    # Create all the UserToDo's for that HealthPlan
  end
end
