class Post < ApplicationRecord

  belongs_to :user

  #アソシエーションで繋がっているとき、まとめてレコードを保存出来るようにするメソッド(+ controller)
  #accepts_nested_attributes_for :post_images
  has_many :post_images, dependent: :destroy
  accepts_attachments_for :post_images, attachment: :image

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy



  #いいねされているか確認するメソッド作成
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  #キーワード検索のメソッド
  def self.search(keyword)
    search ? where(["text like? OR  plase like? OR pet_name like?", "%#{keyword}%",  "%#{keyword}%", "%#{keyword}%"]) : all
  end



  #画像アップする(attachment)為に追加
  attachment :post_image

  enum pet_sex:{
    male: 0,#オス
    female: 1,#メス
    unknown: 2#不明
  }

  enum category:{
    search: 0,#捜索
    protect: 1#保護
  }

  enum animal:{
    dog: 0,#犬
    cat: 1,#猫
    other: 2#そのほか
  }

end
