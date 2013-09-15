class HealthProfilesController < ApplicationController
  before_action :set_health_profile, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @health_profile = HealthProfile.new
  end

  def create
    @health_profile = HealthProfile.new(health_profile_params)

    respond_to do |format|
      if @health_profile.complete
        format.html { redirect_to @health_profile, notice: 'Health profile created!' }
        format.json { render action: 'show', status: :created, location: @health_profile }
      else
        format.html { render action: 'new' }
        format.json { render json: @health_profile.errors, status: :unprocessable_entity }
      end
    end
  end

    private

    def set_health_profile
      @health_profile = HealthProfile.find(params[:id])
    end

    def health_profile_params
      params.require(:health_profile).permit(:id, :male, :dob, :weight, :height, :systolic_bp, :diastolic_bp, :antihypertensive_drugs, :steroid_drugs, :diabetes, :parent_with_diabetes, :sibling_with_diabetes, :smoker, :exsmoker, :cardiovascular_risk, :diabetes_risk)
    end
end
