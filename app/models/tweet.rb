class Tweet < ApplicationRecord
  HASHTAG_REGEX = /(#\w+)/

  before_save :parse_and_save_hashtags
  after_save :parse_and_save_mentions

  belongs_to :user
  belongs_to :parent_tweet, 
             inverse_of: :reply_tweets, 
             foreign_key: :parent_tweet_id, 
             class_name: "Tweet", 
             optional: true,
             counter_cache: :reply_tweets_count

  has_and_belongs_to_many :hashtags
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user  
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_users, through: :bookmarks, source: :user
  has_many :retweets, dependent: :destroy
  has_many :retweeted_users, through: :retweets, source: :user
  has_many :views
  has_many :viewed_users, through: :views, source: :user
  has_many :reply_tweets, foreign_key: :parent_tweet_id, class_name: "Tweet"
  has_many :mentions, dependent: :destroy
  has_many :mentioned_users, through: :mentions

  validates :body, presence: true, length: { maximum: 1000 }

  private

  def parse_and_save_hashtags
    matches = body.scan(HASHTAG_REGEX)
    return if matches.empty?

    matches.flatten.each do |tag|
      hashtag = Hashtag.find_or_create_by(tag: tag.delete("#"))
      hashtags << hashtag unless hashtags.include?(hashtag)
    end
  end

  def parse_and_save_mentions
    matches = body.scan(/(@\w+)/)
    return if matches.empty?

    matches.flatten.each do |mention|
      mentioned_user = User.find_by(username: mention.delete("@"))
      next if mentioned_user.blank?
      mentions.find_or_create_by(mentioned_user: mentioned_user)
      NotificationService.create_mentioned_me_notification(user: mentioned_user, actor: self.user, tweet: self)
    end
  end
end
