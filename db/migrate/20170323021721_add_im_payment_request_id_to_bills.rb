class AddImPaymentRequestIdToBills < ActiveRecord::Migration
  def change
    add_column :bills, :im_payment_request_id, :string
    add_column :bills, :im_payment_id, :string
  end
end
