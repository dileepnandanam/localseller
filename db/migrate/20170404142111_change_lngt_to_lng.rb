class ChangeLngtToLng < ActiveRecord::Migration
  def change
  	rename_column :users, :lngt, :lng
  	rename_column :shops, :lngt, :lng
  end
end
