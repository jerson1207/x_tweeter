class ApplicationController < ActionController::Base
  before_action :redirect_to_username_form, if: -> { user_signed_in? && current_user.username.blank? }

  protected

  def after_sign_in_path_for(resources)
    dashboard_path
  end

  def redirect_to_username_form
    redirect_to new_username_path and return
  end
end
