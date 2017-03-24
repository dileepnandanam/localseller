class AddInstamojoKeysToShop < ActiveRecord::Migration
  def change
  	add_column :shops, :instamajo_api_key, :string
  	add_column :shops, :instamajo_auth_token, :string
  end
end
