class AddParentTweetIdToTweets < ActiveRecord::Migration[7.1]
  def change
    add_column :tweets, :parent_tweet_id, :bigint
    add_index :tweets, :parent_tweet_id
    add_foreign_key :tweets, :tweets, column: :parent_tweet_id
  end
end
