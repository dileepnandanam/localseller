class AddAddressToShop < ActiveRecord::Migration
  def change
    add_column :shops, :address, :text
  end
end
