class AddPriceToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :price, :float
  end
end
