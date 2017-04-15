require 'test_helper'

class BillTest < ActiveSupport::TestCase
  test "correct bill amount" do
  	product_1 = Product.create(price: 10, name: 'asdf')
  	product_2 = Product.create(price: 50, name: 'asdf')
  	
  	shoping_cart_1 = ShopingCart.create
  	shoping_cart_2 = ShopingCart.create
  	purchase_1_1 = shoping_cart_1.purchases.new(product_id: product_1.id, quantity: 1)
  	purchase_1_1.save
  	purchase_1_2 = shoping_cart_1.purchases.new(product_id: product_2.id, quantity: 1)
    purchase_1_2.save
  	purchase_2_1 = shoping_cart_2.purchases.new(product_id: product_1.id, quantity: 1)
  	purchase_2_1.save
  	purchase_2_2 = shoping_cart_2.purchases.new(product_id: product_2.id, quantity: 1)
  	purchase_2_2.save
require 'pry'
binding.pry
  	assert BillValueCalculator.calculate([purchase_1_2, purchase_2_1]) == 17.6
  end
end
