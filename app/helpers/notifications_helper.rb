module NotificationsHelper
  def unchecked_notifications
    # 未確認の時しらせる
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
