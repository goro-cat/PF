class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.references :user, foreign_key: true
      t.text :text
      t.string :plase
      t.string :pet_name
      t.integer :pet_sex

      t.timestamps
    end
  end
end
