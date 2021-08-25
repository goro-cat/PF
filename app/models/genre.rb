class Genre < ApplicationRecord
  has_many :posts, dependent: :destroy

  # 投稿時にfields_forを使用したため追記
  # accepts_nested_attributes_for :posts
  # refileに必要　→　あまり推奨されていないらしいため　×
  # accepts_attachments_for :posts, attachment: :post_image

  enum category: {
    search: 0, # 捜索
    protect: 1 # 保護
  }

  enum animal: {
    dog: 0,  # 犬
    cat: 1,  # 猫
    other: 2 # そのほか
  }
end
