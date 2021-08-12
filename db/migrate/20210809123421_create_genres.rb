class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|
      
      t.integer :type, default: 0, null: false
      t.integer :animal, default: 0, null: false

      t.timestamps
    end
  end
end
