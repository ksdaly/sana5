class UserToDo < ActiveRecord::Base

  belongs_to :user,
    inverse_of: :user_to_dos

  belongs_to :to_do,
    inverse_of: :user_to_dos

  validates_presence_of :day



end
