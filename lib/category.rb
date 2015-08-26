class Category < ActiveRecord::Base
  has_and_belongs_to_many(:recipes)
  validates(:tag, :presence => true)
  
end

class String
  define_method(:separate_tags) do |recipe_to_add_to|
    tags = self.gsub(/, /, ',').split(",")

    tags.each do |tag|
      recipe_to_add_to.categories.push(Category.new({:tag => tag}))
    end
  end
end
