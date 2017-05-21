class Seller::CommentsController < Seller::ShopsController
	before_action :set_shop
	def search

		@comments = @shop.comments.where(
			params[:query].split(' ').map{|search_term|
				"text like '%#{search_term}%'"
			}.join(' AND ')
		)
		render 'seller/shops/comments', layout: false
	end
end