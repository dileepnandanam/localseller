class ShoppersController < ApplicationController
  def shopping_list
  	@shopping_carts = current_user.shoping_carts
  end
end