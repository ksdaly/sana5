class HealthProfilesController < ApplicationController
  before_action :set_health_profile, only: [:show, :edit, :update, :destroy]

  before_action only: [:show, :edit, :update, :destroy] do  |x| x.require_patient! @health_profile end

  def index
    redirect_to_new?
    @health_profiles = HealthProfile.where(user_id: current_user.id)
  end

  def edit
  end

  def new
    redirect_to_edit?
    @health_profile = HealthProfile.new
  end

  def create
    @health_profile = HealthProfile.new(health_profile_params)
    @health_profile.user = current_user
    #TODO: eliminate duplication
    if @health_profile.save
      @health_profile.calculate_risks
      redirect_to new_user_health_plan_path, notice: 'Health profile created!'
    else
      render action: 'new'
    end
  end

  def update
    if old_profile?
      @health_profile = HealthProfile.new(health_profile_params)
      @health_profile.user = current_user
    end

    if @health_profile.update(health_profile_params)
      @health_profile.calculate_risks
      redirect_to health_profiles_path, notice: 'profile was successfully updated.'
    else
      render action: 'edit'
    end
  end

    private

  def old_profile?
    # @health_profile.updated_at.to_date.beginning_of_day != Time.now.utc.to_date
    @health_profile.created_at.to_date != Time.now.utc.to_date
  end

  def set_health_profile
    @health_profile = HealthProfile.find(params[:id])
  end

  def health_profile_params
    params.require(:health_profile).permit(:male, :dob, :weight, :height, :systolic_bp,
      :diastolic_bp, :antihypertensive_drugs, :steroid_drugs, :diabetes, :parent_with_diabetes,
      :sibling_with_diabetes, :smoker, :exsmoker, :cardiovascular_risk, :diabetes_risk)
  end

  def redirect_to_new?
    redirect_to new_health_profile_path if no_profile?
  end

  def redirect_to_edit?
    redirect_to edit_health_profile_path(current_user.health_profiles.last) if !no_profile?
  end

  def no_profile?
    current_user.health_profiles.blank?
  end

end
