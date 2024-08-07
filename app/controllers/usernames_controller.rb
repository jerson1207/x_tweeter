class UsernamesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :redirect_to_username_form, only: [:new, :update]

  def new

  end
  
  def update
    if current_user.update(username_params)
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def username_params
    params.require(:user).permit(:username)
  end
end