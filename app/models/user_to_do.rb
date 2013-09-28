class UserToDo < ActiveRecord::Base

  belongs_to :user,
    inverse_of: :user_to_dos

  belongs_to :to_do,
    inverse_of: :user_to_dos

  validates_presence_of :day


  def self.get_current
    self.where(user_id: @current_user.id, day: Date.today)
  end

  def complete
    if self.completed == false
      self.update(completed: true)
    else
      self.update(completed: false)
    end
  end

  def incomplete?
    self.completed == false
  end

end
