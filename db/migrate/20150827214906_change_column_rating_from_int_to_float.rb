class ChangeColumnRatingFromIntToFloat < ActiveRecord::Migration
  def change
    change_column(:recipes, :avg_rating, :float)
  end
end
