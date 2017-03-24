class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :shop_id
      t.string :name
      t.text :description
      t.integer :price
      t.boolean :deleted, default: false
      t.timestamps null: false
    end
  end
end
