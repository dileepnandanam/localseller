class AddBillIdToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :bill_id, :integer
  end
end
