class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :like_tweets, through: :likes, source: :user

  validates :body, presence: true, length: { maximum: 1000 }
  

end
