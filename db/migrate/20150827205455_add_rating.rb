class AddRating < ActiveRecord::Migration
  def change
    create_table(:ratings) do |t|
      t.column(:rating, :int)
    end

    add_column(:recipes, :avg_rating, :int, default: 0)
  end
end
