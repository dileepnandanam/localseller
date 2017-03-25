class AddSearchableToProduct < ActiveRecord::Migration
  def change
    add_column :products, :searchable, :string
  end
end
