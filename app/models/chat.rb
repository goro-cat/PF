class Chat < ApplicationRecord
  belongs_to :user, optional: true
  has_many :notifications, dependent: :destroy
  # 画像を送れるように
  attachment :chat_image

  # chatの通知
  # （自分以外の）チャットしている相手を取得
  def create_notification_chat!(current_user, chat_id, visited_id)
    temp_ids = Chat.select(:user_id).where(room_id: room_id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, chat_id, temp_id['user_id'])
    end
    # もしチャットが空だったら投稿者に通知
    save_notification_chat!(current_user, chat_id, visited_id) if temp_ids.blank?
  end

  def save_notification_chat!(current_user, chat_id, visited_id)
    notification = current_user.active_notifications.new(
      chat_id: chat_id,
      visited_id: visited_id,
      action: 'chat'
    )
    if notification.visiter_id == notification.visited_id
      notification.cheacked = true
    end
    notification.save if notification.valid?
  end
  
end
