require('spec_helper')

describe(Category) do

  it('will link a category to a recipe') do
    recipe_test = Recipe.create({:name => "Cyanide and Happiness Casserole", :instructions => "Mix Cyanide with some Noodles; Boom, you're done"})
    category_test = Category.new({:tag => 'Quick Recipes', :recipe_ids => [recipe_test.id]})
    expect(category_test.recipes()).to(eq([recipe_test]))
  end
end
