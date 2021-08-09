class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      
      t.integer :user_id,         null: false
      t.integer :genre_id,        null: false
      t.string :post_image_id
      t.text :text,               null: false, default: ""
      t.string :plase,            null: false
      t.string :pet_name
      t.integer :pet_sex,  

      t.timestamps
    end
  end
end
