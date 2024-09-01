class ReplyTweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet

  def create
    @reply_tweet = @tweet.reply_tweets.new(tweet_params.merge(user: current_user))

    if @reply_tweet.save
      respond_to do |format|
        format.html { redirect_to dashboard_path }
        format.turbo_stream
      end
    end
  end

  private

  def set_tweet
    @tweet ||= Tweet.find(params[:tweet_id])
  end

  def tweet_params
    params.require(:tweet).permit(:body)
  end
end
