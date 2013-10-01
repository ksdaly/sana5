class HealthProfilesController < ApplicationController
  before_action :set_health_profile, only: [:show, :edit, :update, :destroy]

  before_action :require_patient!, only: [:show, :edit, :update, :destroy]

  def index

  end

  def edit
  end

  def show
  end

  def new
    @health_profile = HealthProfile.new
  end

  def create
    @health_profile = HealthProfile.new(health_profile_params)
    @health_profile.user_id = current_user.id

      if @health_profile.complete
        redirect_to @health_profile, notice: 'Health profile created!'

      else
        render action: 'new'

      end
  end

  def update

      if @health_profile.update(health_profile_params)
        @health_profile = HealthProfile.new(health_profile_params)
        @health_profile.user_id = current_user.id
        @health_profile.complete
        redirect_to @health_profile, notice: 'profile was successfully updated.'
      else
        render action: 'edit'
      end
  end

    private

    def set_health_profile
      @health_profile = HealthProfile.find(params[:id])
    end

    def health_profile_params
      params.require(:health_profile).permit(:male, :dob, :weight, :height, :systolic_bp,
        :diastolic_bp, :antihypertensive_drugs, :steroid_drugs, :diabetes, :parent_with_diabetes,
        :sibling_with_diabetes, :smoker, :exsmoker, :cardiovascular_risk, :diabetes_risk)
    end

    def require_patient!
      unless current_user.id == @health_profile.user.id
        access_denied
      end
    end
end
