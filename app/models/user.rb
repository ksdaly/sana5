class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :health_profiles,
    inverse_of: :user,
    dependent: :destroy

  has_one :user_health_plan

  has_one :health_plan,
    through: :user_health_plan

  has_many :user_to_dos

  has_many :to_dos,
    through: :user_to_dos

  validates_presence_of :username
  validates_uniqueness_of :username
  validates_format_of :username, with: /\A[A-Za-z0-9_]{1,15}\z/i

end
