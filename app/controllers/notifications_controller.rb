class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.includes(:actor).order(created_at: :desc)
    @notification_presenters = @notifications.map { |notification| NotificationPresenter.new(notification, view_context) }
  end
end