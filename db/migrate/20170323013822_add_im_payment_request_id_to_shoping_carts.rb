class AddImPaymentRequestIdToShopingCarts < ActiveRecord::Migration
  def change
    add_column :shoping_carts, :im_payment_request_id, :string
    add_column :shoping_carts, :im_payment_id, :string
  end
end
