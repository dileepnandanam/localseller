class CreateShopingCarts < ActiveRecord::Migration
  def change
    create_table :shoping_carts do |t|
      t.integer :user_id
      t.boolean :checked_out, default: false
      t.timestamps null: false
    end
  end
end
