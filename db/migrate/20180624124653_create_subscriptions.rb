class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.datetime :start_time
      t.datetime :end_time
      t.integer :im_payment_request_id
      t.timestamps null: false
    end
  end
end
