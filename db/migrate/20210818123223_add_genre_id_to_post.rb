class AddGenreIdToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :category, :integer
    add_column :posts, :animal, :integer
  end
end
