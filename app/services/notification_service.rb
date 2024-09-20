# frozen_string_literal: true

class NotificationService
  attr_reader :notification

  def initialize(notification:)
    @notification = notification
  end

  def send_notification
    NotificationsChannel.broadcast_to(notification.recipient, notification.attributes)
  end
end
