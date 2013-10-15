class UserHealthPlansController < ApplicationController
  before_action :set_user_health_plan, only: [:show, :edit, :update, :destroy]

  before_action only: [:show, :edit, :update, :destroy] do  |x| x.require_patient! @user_health_plan end


  def show
  end

  def new
    @user_health_plan = UserHealthPlan.new
  end

  def create
    @user_health_plan = UserHealthPlan.new(user_health_plan_params)
    @user_health_plan.user_id = current_user.id
      if @user_health_plan.assign
        redirect_to user_to_dos_path, notice: 'Health plan created!'
      else
        render action: 'new'
      end
  end

  private

  def set_user_health_plan
    @user_health_plan = UserHealthPlan.find(params[:id])
  end

  def user_health_plan_params
    params.require(:user_health_plan).permit(:user_id, :health_plan_id)
  end

end
