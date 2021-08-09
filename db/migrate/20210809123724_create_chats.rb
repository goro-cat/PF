class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      
      t.integer :user_id
      t.integer :room_id
      t.text :message
      t.string :chat_image_

      t.timestamps
    end
  end
end
