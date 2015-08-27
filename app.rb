require("bundler/setup")
require 'pry'
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get ("/") do
  @recipes = Recipe.all
  @categories = Category.all
  erb(:index)
end

get('/recipes/new') do
  erb(:add_recipe)
end

post('/recipes/new') do
  name = params['name']
  ingredients = params['ingredients']
  amounts = params['amounts']
  instructions = params['instructions'].gsub(/\n/, "<br>")
  tags = params['tag'].gsub(/, /, ',').split(",")
  @tag_string = params['tag']
  @recipe = Recipe.new({name: name, instructions: instructions})
  @tag = Category.new({tag: @tag_string.gsub(/[, ]/, '')})
  if @recipe.valid? && @tag.valid? && ingredients.each {|ingredient| break if ingredient == ""} && amounts.each {|amount| break if amount == ""}
    existing_tag_ids = []
    tags.each do |tag|
      if Category.find_by(tag: tag) != nil
        existing_tag_ids.push(Category.find_by(tag: tag).id)
      else
        @recipe.categories.push(Category.new({tag: tag}))
      end
    end
    @recipe.update({:category_ids => existing_tag_ids})
    @recipe.save
    count = 0
    amounts.each do |amount|
      new_ingredient = Ingredient.new({:ingredient => ingredients[count]})
      new_ingredient.save
      new_amount = UsedIngredient.new({:amount => amount, :ingredient_id => new_ingredient.id, :recipe_id => @recipe.id})
      new_amount.save
      count += 1
    end
    redirect("/recipes/#{@recipe.id}")
  else
    @recipe.errors[:base] << "Ingredients cannot be blank" if !ingredients.each {|ingredient| break if ingredient == ""}
    @recipe.errors[:base] << "Amounts cannot be blank" if !amounts.each {|amount| break if amount == ""}
    @tag.valid?
    erb(:add_recipe)
  end
end

get('/recipes/:id') do
  @recipe = Recipe.find(params['id'].to_i)
  erb(:recipe_info)
end

get("/categories/:id") do
  @category = Category.find(params['id'].to_i)
  @categories = Category.all
  erb(:category_info)
end

get('/recipe/:id/edit') do
  @recipe = Recipe.find(params['id'].to_i)
  erb(:recipe_edit)
end

patch('/recipes/:id') do
  name = params['name']
  ingredients = params['ingredients']
  amounts = params['amounts']
  instructions = params['instructions'].gsub(/\n/, "<br>")
  tags = params['tags'].gsub(/, /, ",").split(',')
  recipe = Recipe.find(params['id'].to_i)

  existing_tag_ids = []
  tags.each do |tag|
    if Category.find_by(:tag => tag) != nil
      existing_tag_ids.push(Category.find_by(tag: tag).id)
    else
      tag_object = Category.create({:tag => tag})
      existing_tag_ids.push(Category.find_by(tag: tag).id)
    end
  end

  existing_ingredient_ids = []
  count = 0
  ingredients.each do |ingredient|
    if Ingredient.find_by(:ingredient => ingredient) != nil
      ingredient_id = Ingredient.find_by(:ingredient => ingredient).id
      existing_ingredient_ids.push(ingredient_id)
      used_ingredient = UsedIngredient.find_by(:ingredient_id => ingredient_id, :recipe_id => recipe.id)
      used_ingredient.update({:amount => amounts[count]})
    else
      ingredient_object = Ingredient.create({:ingredient => ingredient})
      UsedIngredient.create({:ingredient_id => ingredient_object.id, :recipe_id => recipe.id, :amount => amounts[count]})
      existing_ingredient_ids.push(Ingredient.find_by(:ingredient => ingredient).id)
    end
    count+=1
  end

  recipe.update({:category_ids => existing_tag_ids, :ingredient_ids => existing_ingredient_ids, name: name, instructions: instructions})
  redirect("/recipes/#{recipe.id}")
end

get('/recipe/:id/delete') do
  recipe = Recipe.find(params['id'].to_i)
  recipe.destroy
  redirect("/")
end

get('/category/:id/edit') do
  @category = Category.find(params['id'].to_i)
  erb(:category_edit)
end

patch('/categories/:id') do
  tag = params['tag']
  category = Category.find(params['id'].to_i)
  category.update({tag: tag})
  redirect("/categories/#{category.id}")
end

get('/category/:id/delete') do
  category = Category.find(params['id'].to_i)
  category.destroy
  redirect("/")
end

get('/ingredients/delete/:id/') do
  recipe_id = params['ref'].to_i
  ingredient_id = params['id'].to_i
  ingredient = Ingredient.find(ingredient_id)
  used_ingredient = UsedIngredient.find_by(recipe_id: recipe_id, ingredient_id: ingredient_id)
  used_ingredient.destroy
  ingredient.destroy
  redirect("/recipe/#{recipe_id}/edit")
end
