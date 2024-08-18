class TweetsController < ApplicationController
  before_action :authenticate_user!

  def create
    @tweet = Tweet.new(tweet_params.merge(user: current_user))
    # @tweet = current_user.tweets.new(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to dashboard_path }
        format.turbo_stream
      else
        render :new
      end
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body)
  end
end