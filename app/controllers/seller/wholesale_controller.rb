class  Seller::WholesaleController < Seller::ShopsController
	before_action :set_shop
	def index
		render 'wholesale'
	end
end