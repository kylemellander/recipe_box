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
  instructions = params['instructions']
  @tag_string = params['tag']
  @tag = Category.new({tag: @tag_string.gsub(/[, ]/, '')})
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
