class NotificationsController < ApplicationController
  def index
    # @notificaations = current_user.passive_notifications
    # すべての通知の中で、visited_idが自分でfalseのものをとってくる
    @notifications = Notification.where(visited_id: current_user.id, cheacked: false)
    # include NotificationsHelper
    # testt = NotificationsHelper::Aaa.unchecked_notifications
    # p testt
    # とってきた通知をtrueにかえる
    # byebug
    # @notificaations.each do |notification|
    #  notification.update_attributes(cheacked: true)
    # end

    # @notifications = current_user.passive_notifications.page(params[:page]).per(20)
    # @notifications.where(checked: false).each do |notification|
    #  notification.update_attributes(checked: true)
    # end
  end

  def destroy_all
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
