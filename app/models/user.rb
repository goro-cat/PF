class User < ApplicationRecord
   #Include default devise modules. Others available are:
   #:confirmable, :lockable, :timeoutable, :trackable and :omniauthable
   devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable


   #フォローされているユーザをフォローしている人
   has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
   has_many :following_user, through: :follower, source: :followed_user
   #フォローしているユーザをフォローしている人
   has_many :followed_user, class_name: "Relationship", foreign_key: "followed_user_id", dependent: :destroy
   has_many :follower_user, through: :followed_user, source: :follower

   has_many :chats, dependent: :destroy

  has_many :posts, dependent: :destroy
  #アカウント画像
  attachment :account_image

  def follow(user_id)
    follower.create(followed_user_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(followed_user_id: user_id).destroy
  end

  def following?(user)
    following_user.include?(user)
  end

end
