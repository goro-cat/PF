class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def application
   # @unchecked_notifications = current_user.passive_notifications.where(checked: false)
    @unchecked_notifications = current_user.notifications.where(visited_id: current_user.id, cheacked: false)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:lase_name, :first_name, :kana_last_name, :kana_first_name, :address, :account_name] )
  end

  def after_sign_in_path_for(_resource)
    user_path(current_user)
  end
end
