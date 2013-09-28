class UserToDosController < ApplicationController

  def index
    @user_to_dos = UserToDo.where(user_id: current_user.id, day: Date.today)
  end

  def update
    @user_to_do = UserToDo.find params[:id]
    @user_to_do.complete
    redirect_to user_to_dos_path
  end

end
