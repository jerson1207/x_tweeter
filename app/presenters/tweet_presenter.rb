class TweetPresenter
  include ActionView::Helpers::DateHelper
  include ActionView::Helpers::TagHelper
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::AssetUrlHelper

  attr_reader :tweet, :current_user, :like_presenter, :bookmark_presenter, :retweet_presenter

  def initialize(tweet:, current_user:)
    @tweet = tweet
    @current_user = current_user
    @like_presenter = LikePresenter.new(tweet: tweet, current_user: current_user)
    @bookmark_presenter = BookmarkPresenter.new(tweet: tweet, current_user: current_user)
    @retweet_presenter = RetweetPresenter.new(tweet: tweet, current_user: current_user)
  end

  delegate :bookmark, :user, :body, :created_at, 
           :likes_count, 
           :retweets_count, 
           :views_count, 
           :reply_tweets_count, 
           to: :tweet
  delegate :display_name, :username, :avatar, to: :user
  delegate :url, :request, :heart_icon, to: :like_presenter, prefix: :like
  delegate :url, :request, :bookmark_icon, to: :bookmark_presenter, prefix: :bookmark
  delegate :url, :request, :retweet_icon, to: :retweet_presenter, prefix: :retweet

  def avatar
    return user.avatar if user.avatar.present?
    'user-profile.svg'
  end

  def formatted_created_at
    if time_difference > 1.day
      tweet.created_at.strftime("%b %-d")
    else
      "#{time_ago_in_words(tweet.created_at)} ago"
    end
  end

  def formatted_time
    tweet.created_at.strftime("%l:%M %p")
  end

  def formatted_full_date
    tweet.created_at.strftime("%b %d, %Y")
  end

  private 

  def time_difference
    Time.zone.now - tweet.created_at
  end  
end
