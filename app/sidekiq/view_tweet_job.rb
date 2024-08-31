class ViewTweetJob
  include Sidekiq::Worker

  def perform(tweet_id, user_id)
    tweet = Tweet.find(tweet_id)
    user = User.find(user_id)
    
    unless tweet_viewed?(tweet, user)
      View.create(tweet: tweet, user: user)
    end
  end

  private

  def tweet_viewed?(tweet, user)
    View.exists?(tweet: tweet, user: user)
  end
end
