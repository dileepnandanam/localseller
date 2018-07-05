class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.integer :user_id
      t.string :action_type

      t.timestamps null: false
    end
  end
end
