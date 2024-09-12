class ProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  
  def show
    @tweet_presenters = @user.tweets.map do |tweet|
      TweetPresenter.new(tweet: tweet, current_user: @user)
    end
    render "users/show"
  end

  def update

    if @user.update(user_params)
      respond_to do |format|
        format.html { redirect_to profile_path, notice: 'Profile updated successfully' }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { render "users/show", status: :unprocessable_entity } # Ensure consistent rendering
      end
    end
  end 

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:username, :display_name, :email, :password, :location, :bio, :url).tap do |whitelisted|
      whitelisted.delete(:password) if whitelisted[:password].blank?
    end
  end
end
