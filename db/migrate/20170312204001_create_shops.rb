class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :name
      t.string :permalink
      t.string :phone_number 
      t.string :pincode
      t.string :email
      t.text :description
      t.integer :lat
      t.integer :lngt
      t.integer :user_id

      t.timestamps null: false


    end

    add_index :shops, :permalink, unique: true
  end
end
