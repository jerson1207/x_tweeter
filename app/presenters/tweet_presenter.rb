class TweetPresenter
  include ActionView::Helpers::DateHelper

  attr_reader :tweet

  def initialize(tweet)
    @tweet = tweet
  end

  delegate :user, :body, :likes, :likes_count, to: :tweet
  delegate :display_name, :username, :avatar, to: :user

  def formatted_created_at
    if time_difference > 1.day
      tweet.created_at.strftime("%b %-d")
    else
      "#{time_ago_in_words(tweet.created_at)} ago"
    end
  end

  private

  def time_difference
    Time.zone.now - tweet.created_at
  end
end
