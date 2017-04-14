class ShoppersController < ApplicationController
  def shopping_list
  	@shopping_carts = current_user.shoping_carts.select{|cart| cart.purchases.map(&:payed).uniq == true}
  end
end