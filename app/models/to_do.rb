class ToDo < ActiveRecord::Base

  belongs_to :health_plan,
    inverse_of: :to_dos

  has_many :user_to_dos

  has_many :users,
    through: :user_to_dos,
    dependent: :destroy

  validates_presence_of :title
  validates_presence_of :description

end
