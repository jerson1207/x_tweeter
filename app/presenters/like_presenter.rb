class LikePresenter
  include ActionView::Helpers::TagHelper
  include Rails.application.routes.url_helpers

  attr_reader :tweet, :current_user

  def initialize(tweet:, current_user:)
    @tweet = tweet
    @current_user = current_user
  end

  def url
    if tweet_liked_by_current_user
      tweet_like_path(tweet, current_user.likes.find_by(tweet: tweet))
    else
      tweet_likes_path(tweet)
    end
  end

  def request
    tweet_liked_by_current_user ? "delete" : "post"
  end

  def heart_icon
    content_tag(:i, nil, class: heart_icon_class)
  end

  private

  def tweet_liked_by_current_user
    @tweet_liked_by_current_user ||= current_user.likes.exists?(tweet: tweet)
  end

  def heart_icon_class
    tweet_liked_by_current_user ? 'fa-solid fa-heart' : 'fa-regular fa-heart'
  end
end
