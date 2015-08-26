class AddAmountDefault < ActiveRecord::Migration
  def change
    change_column(:used_ingredients, :amount, :string, :default => "")
  end
end
