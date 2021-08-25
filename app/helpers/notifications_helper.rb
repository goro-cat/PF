module NotificationsHelper
  class Aaa
    def notification_form(notification)
      @visiter = notification.visiter
      @comment = nil
      # = link_to 'あなたの投稿', users_post_path(notification), style:"font-weight: bold;"
      # @visiter.comment = notification.comment_id

      case notification.action
      when 'follow'
        tag.a(notification.visiter.name, href: users_user_path(@visiter),
                                         style: 'font-weight: bold;') + 'があなたをフォローしました'
      when 'comment'
        @comment = Comment.find_by(id: @visiter_comment)&.content
        tag.a(@visiter.name, href: users_user_path(@visiter),
                             style: 'font-weight: bold;') + 'が' + tag.a('あなたの投稿', href: users_item_path(notification.item_id),
                                                                                  style: 'font-weight: bold;') + 'にコメントしました'
      end
    end

    # 未確認の時しらせる
    def unchecked_notifications
      @notifications = current_user.passive_notifications.where(checked: false)
    end
  end
end
