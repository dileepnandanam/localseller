class CreateAuthHashes < ActiveRecord::Migration
  def change
    create_table :auth_hashes do |t|
      t.string :uid
      t.string :name
      t.string :email
      t.string :provider
      t.string :user_id
      t.timestamps null: false
    end
  end
end
