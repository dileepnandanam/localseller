class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :shoping_cart_id
      t.integer :shop_id
      t.string :product_id
      t.boolean :payed, default: false
      t.boolean :payed_out, default: false
      t.integer :user_id
      t.integer :quantity
      t.boolean :shiped, default: false
      t.timestamps null: false
    end
  end
end
