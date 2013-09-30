class UserToDosController < ApplicationController

  before_action :set_user_to_do, only: [:update]

  def index
    @user_to_dos = UserToDo.where(user_id: current_user.id, day: Date.today).order(:id)
  end

  def update
    if @user_to_do.update(user_to_do_params)
      respond_to do |format|
      format.html { redirect_to user_to_dos_path }
      format.js
      end
    end
  end

  private

  def set_user_to_do
  	@user_to_do = UserToDo.find(params[:id])
  end

  def user_to_do_params
    params.require(:user_to_do).permit(:completed)
  end

end
