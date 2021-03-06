class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:name])
    devise_parameter_sanitizer.permit(:account_update, keys:[:name])
  end

  def set_all_chat_groups
    @chat_groups = current_user.chat_groups.includes(:messages).all
  end

  def reject_nonmember
    redirect_to :root unless current_user.join_in?(@chat_group)
  end
end
