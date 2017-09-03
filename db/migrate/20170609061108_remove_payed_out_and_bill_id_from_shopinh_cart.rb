class RemovePayedOutAndBillIdFromShopinhCart < ActiveRecord::Migration
  def change
  	remove_column :shoping_carts, :payed_out, :boolean
  	remove_column :shoping_carts, :bill_id, :integer
  end
end
