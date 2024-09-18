class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweet_presenters = Tweet.includes(:user, :liked_users, :bookmarked_users).order(created_at: :desc).map do |tweet|
      TweetPresenter.new(tweet: tweet, current_user: current_user) 
    end
  end
end