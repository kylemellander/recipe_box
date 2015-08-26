class CreateIngredientsAndUsedIngredientsTables < ActiveRecord::Migration
  def change
    create_table(:ingredients) do |t|
      t.column(:ingredient, :string)
    end

    create_table(:used_ingredients) do |t|
      t.column(:ingredient_id, :int)
      t.column(:recipe_id, :int)
      t.column(:amount, :varchar)
    end
  end
end
