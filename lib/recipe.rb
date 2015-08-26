class Recipe < ActiveRecord::Base
  has_and_belongs_to_many(:categories)
  has_many(:used_ingredients)
  has_many(:ingredients, through: :used_ingredients)

  validates(:name, :presence => true)
  validates(:instructions, :presence => true)

  def display_tags
    tags = []
    categories.each do |c|
      tags.push("<a href='/categories/#{c.id}'>#{c.tag}</a>")
    end
    tags.join(", ")
  end
  
end
