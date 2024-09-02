class ProfileController < ApplicationController
  before_action :authenticate_user!
  
  def show
  end

  def update
    current_user.update(user_params[:password].blank? ? user_params.except(:password) : user_params)
    respond_to do |format|
      format.html { redirect_to profile_path, notice: 'Profile updated successfully' }
      format.turbo_stream
    end
  end  

  private

  def user_params
    params.require(:user).permit(:username, :display_name, :email, :password, :location, :bio, :url)
  end
end
