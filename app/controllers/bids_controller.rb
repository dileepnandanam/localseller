class BidsController < ApplicationController
  def create
    @bid = Bid.new(bid_params)
    @bid.user_id = current_user.id
    if bid.save
      render 'show', layout: false, status: 200
    else
      render 'new', layout: false, status: 422
    end
  end

  def show
    @bid = current_user.bids.find(params[:id])
  end

  def index
    @product_bids = current_user.bids.group_by(&:product)
  end

  def new
    @bid = Bid.new
    render 'new', layout: false
  end

  def delete
    bid = current_user.bids.find(params[:id])
    bid.delete
  end

  protected
  def bid_params
    params.require(:bids).permit(:product_id, :amount, :quantity)
  end
end