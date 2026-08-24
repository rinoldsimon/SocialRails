class ApplicationController < ActionController::Base
  include Pundit::Authorization

  allow_browser versions: :modern
  stale_when_importmap_changes

  before_action :authenticate_user!, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :username ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :username, :bio, :github_username ])
  end

  def user_not_authorized
    redirect_back fallback_location: root_path, alert: "You can't do that."
  end
end
