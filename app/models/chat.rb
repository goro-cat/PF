class Chat < ApplicationRecord
  
  belongs_to :user, optional: true
  #画像を送れるように
  attachment :chat_image
end
