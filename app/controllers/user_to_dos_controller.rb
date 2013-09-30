class UserToDosController < ApplicationController

  def index
    @user_to_dos = UserToDo.where(user_id: current_user.id, day: Date.today).order(:id)
  end

  def complete
    UserToDo.where(id: params[:redo_ids], completed: true).update_all(completed: false)
    UserToDo.where(id: params[:user_to_do_ids], completed: false).update_all(completed: true)
    redirect_to user_to_dos_path
  end

end
