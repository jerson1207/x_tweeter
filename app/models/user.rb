class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save  :set_display_name, if: -> { username.present? && display_name.blank? }

  has_one_attached :avatar 
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_tweets, through: :likes, source: :tweet

  validates :username, uniqueness: { case_sensitive: false }, allow_blank: true

  def set_display_name
    self.display_name = username.humanize
  end
end
  