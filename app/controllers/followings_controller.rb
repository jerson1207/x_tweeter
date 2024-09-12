class FollowingsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:following_user_id])
    current_user.followings.create(following_params)
    respond_to do |format|
      format.html { redirect_to user_path(@user) }
      format.turbo_stream
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    following = Following.find(params[:id])
    following.destroy
    respond_to do |format|
      format.html { redirect_to user_path(@user) }
      format.turbo_stream
    end
  end

  private

  def following_params
    params.permit(:following_user_id)
  end
end