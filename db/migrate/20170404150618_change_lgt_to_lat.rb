class ChangeLgtToLat < ActiveRecord::Migration
  def change
  	rename_column :users, :lgt, :lat
  end
end
