class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index 
    @tweet_presenters = current_user.bookmarked_tweets.map do |tweet|
      TweetPresenter.new(tweet: tweet, current_user: current_user)
    end
  end

  def create
    @bookmark = current_user.bookmarks.create(tweet: tweet)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to dashboard_path }
    end
    
  end

  def destroy
    @bookmark = tweet.bookmarks.find(params[:id])
    @bookmark.destroy
    respond_to  do |format|
      format.turbo_stream
    end
  end

  private

  def tweet
    @tweet ||= Tweet.find(params[:tweet_id])
  end
end