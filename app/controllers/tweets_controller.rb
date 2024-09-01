class TweetsController < ApplicationController
  before_action :authenticate_user!

  def show
    ViewTweetJob.perform_async(tweet.id, current_user.id)
    @tweet_presenter = TweetPresenter.new(tweet: @tweet, current_user: current_user)
    @reply_tweets_presenters = tweet.reply_tweets
                                    .includes(:user, :liked_users, :bookmarked_users)
                                    .order(created_at: :desc)
                                    .map do |reply_tweet|
      TweetPresenter.new(tweet: reply_tweet, current_user: current_user)
    end
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

  def tweet
    @tweet ||= Tweet.find(params[:id])
  end

  def create_view_record!
    View.create(tweet: tweet, user: current_user)
  end
end