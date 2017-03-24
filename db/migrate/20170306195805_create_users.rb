class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :usertype
      t.string :name
      t.text :address
      t.string :pincode
      t.string :phone_number

      t.timestamps null: false
    end
  end
end
