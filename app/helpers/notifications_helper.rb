module NotificationsHelper
  def notifiable_path(notification)
    public_send("#{notification.notifiable_type.downcase}_path", notification.notifiable_id)
  end
end
