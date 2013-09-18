class HealthProfilesController < ApplicationController
  before_action :set_health_profile, only: [:show, :edit, :update, :destroy]

  def edit
  end

  def show
  end

  def new
    @health_profile = HealthProfile.new
  end

  def create
    @health_profile = HealthProfile.new(health_profile_params)


      if @health_profile.complete
        redirect_to @health_profile, notice: 'Health profile created!'

      else
        render action: 'new'

      end
  end

  def update
    respond_to do |format|
      if @health_profile.update(health_profile_params)
        @health_profile = HealthProfile.new(health_profile_params)
        @health_profile.complete
        format.html { redirect_to @health_profile, notice: 'profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @health_profile.errors, status: :unprocessable_entity }
      end
    end
  end

    private

    def set_health_profile
      @health_profile = HealthProfile.find(params[:id])
    end

    def health_profile_params
      params.require(:health_profile).permit(:male, :dob, :weight, :height, :systolic_bp, :diastolic_bp, :antihypertensive_drugs, :steroid_drugs, :diabetes, :parent_with_diabetes, :sibling_with_diabetes, :smoker, :exsmoker, :cardiovascular_risk, :diabetes_risk)
    end
end
