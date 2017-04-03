class ChangeIntegerToFloatForSgop < ActiveRecord::Migration
  def change
  	change_column :shops, :lat, :float
  	change_column :shops, :lngt, :float
  end
end
