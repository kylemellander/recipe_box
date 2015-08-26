class CreateTables < ActiveRecord::Migration
  def change
    create_table(:recipes) do |t|
      t.column(:instructions, :text)

      t.timestamps(null: false)
    end

    create_table(:categories) do |t|
      t.column(:tag, :string)

      t.timestamps(null: false)
    end

    create_table(:categories_recipes) do |t|
      t.column(:category_id, :int)
      t.column(:recipe_id, :int)
    end
  end
end
