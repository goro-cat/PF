class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # フォローされているユーザをフォローしている人
  has_many :follower, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followings, through: :follower, source: :followed_user
  # フォローしているユーザをフォローしている人
  has_many :followed_user, class_name: 'Relationship', foreign_key: 'followed_user_id', dependent: :destroy
  has_many :followers, through: :followed_user, source: :follower

  has_many :chats, dependent: :destroy

  # has_many :post_images
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # 通知機能 active_notification自分からの通知 passive_notification相手からの通知
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visiter_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  # アカウント画像
  attachment :account_image

  def follow(user_id)
    follower.create(followed_user_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(followed_user_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  # フォローされたとき通知作成
  def create_notification_follow!(current_user)
    # Notificationのカラムに直接データを指定する
    temp = Notification.where(['visiter_id = ? and visited_id = ? and action = ?', current_user.id, id, 'follow'])
    if temp.blank?
      notification = Notification.new(
        visiter_id: current_user.id,
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end
