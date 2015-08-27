class Rating < ActiveRecord::Base
  belongs_to(:recipe)

  after_save(:average_all_ratings)

  private

  define_method(:average_all_ratings) do
    all_ratings = Rating.where("recipe_id = #{recipe_id}")
    count = 0
    sum = 0
    all_ratings.each do |rating|
      sum = sum + rating.rating
      count += 1
    end

    recipe = Recipe.find(recipe_id)
    avg_rating = sum/count
    recipe.update({:avg_rating => avg_rating})
  end
end
