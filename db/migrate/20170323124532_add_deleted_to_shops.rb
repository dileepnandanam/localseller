class AddDeletedToShops < ActiveRecord::Migration
  def change
    add_column :shops, :deleted, :boolean, default: false
  end
end
