class AddDeliverableToProducts < ActiveRecord::Migration
  def change
    add_column :products, :deliverable, :boolean, default: true
    
  end
end
