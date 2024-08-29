class BookmarkPresenter
  include ActionView::Helpers::TagHelper
  include Rails.application.routes.url_helpers

  attr_reader :tweet, :current_user

  def initialize(tweet:, current_user:)
    @tweet = tweet
    @current_user = current_user
  end

  def url
    if tweet_bookmarked_by_current_user?
      tweet_bookmark_path(tweet, bookmark_id)
    else
      tweet_bookmarks_path(tweet)
    end
  end

  def request
    tweet_bookmarked_by_current_user? ? "delete" : "post"
  end

  def bookmark_icon
    content_tag(:i, nil, class: tweet_bookmarked_by_current_user? ? 'fa-solid fa-bookmark' : 'fa-regular fa-bookmark')
  end

  private 

  def tweet_bookmarked_by_current_user?
    @tweet_bookmarked_by_current_user ||= current_user.bookmarks.exists?(tweet: tweet)
  end

  def bookmark_id
    @bookmark_id ||= current_user.bookmarks.find_by(tweet: tweet)&.id
  end
end
