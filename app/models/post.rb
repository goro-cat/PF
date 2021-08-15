class Post < ApplicationRecord
  
  belongs_to :user
  belongs_to :genre, required: true
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  #画像アップする(attachment)為に追加
  attachment :post_image
  
  enum pet_sex:{
    male: 0,#オス
    female: 1,#メス
    unknown: 2#不明
  }
  
end
