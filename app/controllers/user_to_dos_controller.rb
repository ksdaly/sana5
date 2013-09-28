class UserToDosController < ApplicationController

  def index
    @user_to_dos = UserToDo.where(user_id: current_user.id, day: Date.today)
  end

end
