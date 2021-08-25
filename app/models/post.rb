class Post < ApplicationRecord
  validates :category, :animal, :plase, :pet_sex, :text, presence: true
  # デフォルトで作成日時の降順
  default_scope -> { order(created_at: :desc) }

  belongs_to :user

  # アソシエーションで繋がっているとき、まとめてレコードを保存出来るようにするメソッド(+ controller)
  # accepts_nested_attributes_for :post_images
  has_many :post_images, dependent: :destroy
  accepts_attachments_for :post_images, attachment: :image

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :notifications, dependent: :destroy

  # いいねされているか確認するメソッド
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # キーワード検索のメソッド
  def self.retrieval(keyword)
    if search
      where(['text like? OR  plase like? OR pet_name like?', "%#{keyword}%", "%#{keyword}%",
             "%#{keyword}%"])
    else
      all
    end
  end

  # いいねの通知機能
  # def create_notification_by(current_user)
  #  notification = current_user.active_notifications.new(
  #    post_id: id,
  #    visited_id: user_id,
  #    action: "favorite"
  #    )
  #    notification.save if notification.valid?
  # end

  # 自分の投稿に自分以外にコメントしている人をすべて取得＋全員(temp_ids)に通知を送る
  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしてないとき、投稿者に通知
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  # コメントが複数回することがあり得るため、1つの投稿に複数回通知＋自分に対するコメントは通知済み
  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    notification.cheacked = true if notification.visiter_id == notification.visited_id
    notification.save if notification.valid?
  end

  # 画像アップする(attachment)為に追加
  # attachment :post_image

  enum pet_sex: {
    オス: 0,
    メス: 1,
    不明: 2
  }

  enum category: {
    捜索中: 0,
    保護中: 1
  }

  enum animal: {
    犬: 0,
    猫: 1,
    その他: 2
  }
end
