class Relationship < ApplicationRecord
  # relationshipのカラムとuserをつなげるため
  belongs_to :follower, class_name: 'User'
  belongs_to :followed_user, class_name: 'User'

  def follow(user_id)
    relationships.create(followed_user_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_user_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
end
