class Hashtag < ApplicationRecord
  validates :tag, presence: true, uniqueness: { case_sensitive: false }

  has_and_belongs_to_many :tweets
end
