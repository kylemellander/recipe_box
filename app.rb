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
  instructions = params['instructions'].gsub(/\n/, "<br>")
  @tag_string = params['tag']
  @tag = Category.new({tag: @tag_string.gsub(/[, ]/, '')})
  binding.pry
  all_categories = Category.all
  @recipe = Recipe.new({name: name, instructions: instructions})
  tags = params['tag'].gsub(/, /, ',').split(",")
  if @recipe.valid? && @tag.valid?
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
    redirect("/recipes/#{@recipe.id}")
  else
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
  instructions = params['instructions'].gsub(/\n/, "<br>")
  recipe = Recipe.find(params['id'].to_i)
  recipe.update({name: name, instructions: instructions})
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
  if Category.find_by(:tag => tag) != nil

  end
  category = Category.find(params['id'].to_i)
  category.update({tag: tag})
  redirect("/categories/#{category.id}")
end

get('/category/:id/delete') do
  category = Category.find(params['id'].to_i)
  category.destroy
  redirect("/")
end
