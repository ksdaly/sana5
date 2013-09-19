class HealthPlansController < ActionController::Base
  before_action :set_health_plan, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @health_plan = HealthPlan.new
  end

  def create
    @health_plan = HealthPlan.new(health_plan_params)
    if @health_plan.save
      redirect_to @health_plan, notice: 'Health plan created!'
    else
      render action: 'new'
    end
  end

  private

  def set_health_plan
    @health_plan = HealthPlan.find(params[:id])
  end

  def health_plan_params
    params.require(:health_plan).permit(:title, :description)
  end
end
