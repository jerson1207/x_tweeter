  class RetweetPresenter
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::AssetTagHelper

    include Rails.application.routes.url_helpers

    attr_reader :tweet, :current_user

    def initialize(tweet:, current_user:)
      @tweet = tweet
      @current_user = current_user
    end

    def url
      tweet_retweeted_by_current_user ? tweet_retweet_path(tweet, current_user.retweets.find_by(tweet: tweet)) : tweet_retweets_path(tweet)
    end

    def request
      tweet_retweeted_by_current_user ? "delete" : "post"
    end

    def retweet_icon
      image_path = tweet_retweeted_by_current_user ? 'repeat-solid.svg' : 'repeat.svg'
      ApplicationController.helpers.image_tag(image_path, alt: 'Retweet', class: 'w-[20px] h-[20px]')
    end

    private 

    def tweet_retweeted_by_current_user
      @tweet_retweeted_by_current_user ||= tweet.retweeted_users.include?(current_user)
    end
  end