class NotificationPresenter
  attr_reader :notification

  def initialize(notification, view_context)
    @notification = notification
    @actor = notification.actor
    @view = view_context
  end

  delegate :actor, :verb, :user, :tweet, to: :notification

  def avatar_image(options = {})
    options = options.merge(class: "w-12 h-12 rounded-full")
    if @actor.avatar.attached?
      avatar_variant = @actor.avatar
      @view.image_tag avatar_variant, options
    else
      @view.image_tag 'user-profile.svg', options
    end
  end

  def message
    case verb
    when 'followed-me'
      "<span class='font-bold'>#{actor.display_name}</span> followed you. <p>#{@view.link_to 'View Profile', @view.user_path(actor)} </p>"
    when 'liked-tweet'
      truncated_body = @view.truncate(tweet.body, length: 100, omission: '...')
      "<span class='font-bold'>#{actor.display_name}</span> liked your tweet. <p>#{truncated_body}</p> #{@view.link_to 'View Tweet', @view.tweet_path(tweet)}".html_safe
    when 'mentioned-me'
      truncated_body = @view.truncate(tweet.body, length: 100, omission: '...')
      "<span class='font-bold'>#{actor.display_name}</span> mention you in a tweet tweet. <p>#{truncated_body}</p> #{@view.link_to 'View Tweet', @view.tweet_path(tweet)}".html_safe
    else
      "You have a new notification."
    end
  end


  def display
    <<~HTML.html_safe
      <div class="m-4">
        <div class="mb-2">
          #{avatar_image}
        </div>
        <div class="notification-message">
          #{message}
        </div>
      </div>
      <hr>
    HTML
  end
end
