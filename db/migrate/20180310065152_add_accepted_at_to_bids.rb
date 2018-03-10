class AddAcceptedAtToBids < ActiveRecord::Migration
  def change
    add_column :bids, :accepted_at, :datetime
  end
end
