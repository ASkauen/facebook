class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  private

  def after_sign_out_path_for(resource_or_scope)
    new_session_path(resource_name)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:first_name, :last_name]
  end
end
