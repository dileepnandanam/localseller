class AddLgtLngtToUser < ActiveRecord::Migration
  def change
    add_column :users, :lgt, :float
    add_column :users, :lngt, :float
  end
end
