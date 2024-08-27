class TweetsController < ApplicationController
  before_action :authenticate_user!

  def show
    @tweet = Tweet.find(params[:id])

    @tweet_presenter = TweetPresenter.new(tweet: @tweet, current_user: current_user)
  end

  def create
    @tweet = Tweet.new(tweet_params.merge(user: current_user))

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