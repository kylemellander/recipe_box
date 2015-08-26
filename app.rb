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
  @recipe = Recipe.new({:name => name, :instructions => instructions})
  params['tag'].separate_tags(@recipe)
  if @recipe.save && @tag_string != ""
    redirect("/recipes/#{@recipe.id}")
  else
    erb(:add_recipe)
  end
end

get('/recipes/:id') do
  @recipe = Recipe.find(params['id'].to_i)
  erb(:recipe_info)
end
