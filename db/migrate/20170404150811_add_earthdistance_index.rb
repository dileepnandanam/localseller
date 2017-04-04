class AddEarthdistanceIndex < ActiveRecord::Migration
  def up
    add_earthdistance_index :users
    add_earthdistance_index :shops
  end

  def down
    remove_earthdistance_index :users
    remove_earthdistance_index :shops
  end
end

