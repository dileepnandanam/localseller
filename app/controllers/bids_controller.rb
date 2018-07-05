class BidsController < ApplicationController
  before_action :check_subscription, only: :new
  def create
    @bid = Bid.new(bid_params)
    @product = Product.find(bid_params[:product_id])
    @bid.user_id = current_user&.id
    @bid.accepted_at = Time.at(0)
    if @bid.save
      render 'success', layout: false, status: 200
    else
      render 'new', layout: false, status: 422
    end
  end

  def show
    @bid = current_user.bids.find(params[:id])
  end

  def index
    @product = Product.find(params[:product_id])
    @bids = @product.bids.order('amount DESC')
    render 'index', layout: false
  end

  def new
    @product = Product.find(params[:product_id])
    @bid = Bid.new
    render 'new', layout: false
  end

  def destroy
    bid = Bid.find(params[:id])
    if current_user.bids.include?(bid) || current_user.shops.map(&:products).flatten.include?(bid.product)
      seller = bid.product.shop.user
      bid.delete
      if bid.accepted
        bid.product.update_attributes(quantity: bid.product.quantity + bid.quantity)
        Rails.cache.write("#{current_user.id}/last_seen_accepted_bid_count", [(Rails.cache.fetch("#{current_user.id}/last_seen_accepted_bid_count").to_i - 1), 0].max)
      else
        Rails.cache.write("#{seller.id}/last_seen_bid_count", [(Rails.cache.fetch("#{seller.id}/last_seen_bid_count").to_i - 1), 0].max)
      end
      render nothing: true, status: 200
    else
      render nothing: true, status: 406
    end
  end

  def accept
    bid = Bid.find(params[:id])
    if current_user.shops.map(&:products).flatten.include?(bid.product)
      bid.accepted = true
      bid.accepted_at = Time.now
      bid.save
      bid.product.update_attributes(quantity: (bid.product.quantity - bid.quantity))
      Rails.cache.write("#{current_user.id}/last_seen_bid_count", Rails.cache.fetch("#{current_user.id}/last_seen_bid_count").to_i - 1)
      Action.create(user_id: current_user.id, action_type: 'accept_bid')
      Action.create(user_id: bid.user_id, action_type: 'bid_accepted')
    end
    render nothing: true, status: 200
  end

  protected

  def check_subscription
    subscription = current_user.subscription
    if current_user.usertype != "admin" && have_accepted_bids && !Time.now.between?(subscription.start_time, subscription.end_time)
      render 'subscribe_link', layout: false
    end
  end

  def have_accepted_bids
    Action.where(user_id: current_user.id, action_type: 'bid_accepted').count > 0
  end

  def bid_params
    params.require(:bid).permit(:product_id, :amount, :quantity)
  end
end