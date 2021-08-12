class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|

      t.integer :user_id
      t.integer :genre_id
      t.string :post_image_id
      t.text :text
      t.string :plase
      t.string :pet_name
      t.integer :pet_sex

      t.timestamps
    end
  end
end