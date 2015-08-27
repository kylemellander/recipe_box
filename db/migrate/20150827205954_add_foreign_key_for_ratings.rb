class AddForeignKeyForRatings < ActiveRecord::Migration
  def change
    add_column(:ratings, :recipe_id, :int)
  end
end
