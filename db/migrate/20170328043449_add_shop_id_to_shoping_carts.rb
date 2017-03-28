class AddShopIdToShopingCarts < ActiveRecord::Migration
  def change
    add_column :shoping_carts, :shop_id, :integer
    add_column :shoping_carts, :payed_out, :boolean, default: false
    add_column :shoping_carts, :bill_id, :integer
  end
end
