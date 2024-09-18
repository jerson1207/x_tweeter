class HashtagsController < ApplicationController
  def index
    
    @hashtags = Hashtag.includes(:tweets)
  end

  def show
    @hashtag = Hashtag.find(params[:id])
    @tweet_presenters = @hashtag.tweets.order(created_at: :desc).map do |tweet|
      TweetPresenter.new(tweet: tweet, current_user: current_user) 
    end
  end
end
