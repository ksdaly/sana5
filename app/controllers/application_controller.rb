class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def access_denied
    flash[:error] = 'Access Denied'
    redirect_to root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
  end


  def require_patient!(resource)
    unless current_user.id == resource.user.id
      access_denied
    end
  end

  def after_sign_in_path_for(resource)
    if resource.health_profiles.blank?
      new_health_profile_path
    elsif resource.health_plan.blank?
      new_user_health_plan_path
    else
      user_to_dos_path
    end
  end
end
