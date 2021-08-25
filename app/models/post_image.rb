class PostImage < ApplicationRecord
  belongs_to :post
  # 複数保存するためにgem:carriewave → uploaderファイルとカラムをつなげる
  # mount_uploaders :image, ImagesUploader
  attachment :image
end
