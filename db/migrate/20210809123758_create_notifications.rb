class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      
      t.integer :visitor_id
      t.integer :visited_id
      t.integer :comment_id
      t.integer :chat_id
      t.integer :action
      t.boolean :cheacked,     null: false,  default: ""

      t.timestamps
    end
  end
end
