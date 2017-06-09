class RemovePayedOutAndBillIdFromShopinhCart < ActiveRecord::Migration
  def change
  	remove_column :shoping_carts, :payed_out
  	remove_column :shoping_carts, :bill_id
  end
end
