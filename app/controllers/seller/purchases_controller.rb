class Seller::PurchasesController < Seller::ShopsController
	before_action :set_shop
	def index
		@purchases = @shop.purchases.where(payed: true).where(categories[filter_params[:filter]|| :new_purchases])
		
		render 'seller/shops/purchases/index'
	end

	def shipped
		purchase = @shop.purchases.find(params[:id])
		if purchase.update_attributes(shiped: true)
			render nothing: true, head: :ok
		else
			render head: 422
		end

	end

	protected
	def filter_params
		params.permit(:filter)
	end

	def categories
	   {
	   	    new_purchases: {payed: true, payed_out: false, shiped: false},
	   	    shiped_purchases: {payed: true, shiped: true, payed_out: false}
	
	   	}.with_indifferent_access
	end
end