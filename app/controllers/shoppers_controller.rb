class ShoppersController < ApplicationController
  def shopping_list
  	@shoping_carts = current_user.shoping_carts
  end
end