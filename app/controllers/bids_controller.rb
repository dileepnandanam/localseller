class BidsController < ApplicationController
  def create
    @bid = Bid.new(bid_params)
    @bid.user_id = current_user.id
    if @bid.save
      render 'show', layout: false, status: 200
    else
      render 'new', layout: false, status: 422
    end
  end

  def show
    @bid = current_user.bids.find(params[:id])
  end

  def new
    @product = Product.find(params[:product_id])
    @bid = Bid.new
    render 'new', layout: false
  end

  def destroy
    bid = Bid.find(params[:id])
    if current_user.bids.include?(bid) || current_user.shops.map(&:products).flatten.include?(bid.product)
      bid.delete
      render nothing: true, status: 200
    else
      render nothing: true, status: 406
    end
  end

  def accept
    bid = Bid.find(params[:id])
    if current_user.shops.map(&:products).flatten.include?(bid.product)
      bid.accepted = true
      bid.save
      bid.product.update_attributes(quantity: (bid.product.quantity - bid.quantity))
    end
    render nothing: true, status: 200
  end

  protected
  def bid_params
    params.require(:bid).permit(:product_id, :amount, :quantity)
  end
end