class NotificationService
  def self.create_followed_me_notification(params = {})
    Notification.create!(
      user: params[:user],
      actor: params[:actor],
      verb: 'followed-me',
      tweet: nil
    )
  end

  def self.create_liked_tweet_notification(params = {})
    Notification.create(
      user: params[:user],
      actor: params[:actor],
      verb: 'liked-tweet',
      tweet: params[:tweet]
    )
  end

  def self.create_mentioned_me_notification(params = {})
    Notification.create(
      user: params[:user],
      actor: params[:actor],
      verb: 'mentioned-me',
      tweet: params[:tweet]
    )
  end
end