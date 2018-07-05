class Seller::ShopsController < SellerController
  before_action :set_shop, only: [:edit, :update, :show]
  before_action :set_current_shop, only: [:inventory, :past_purchases, :open_bids]
  before_action :check_subscription, only: :inventory
  def new
    @shop = Shop.new
    @shop.user_id = current_user.id
  end

  def index
    @shops = current_user.shops
  end

  def show
  	@new_purchases = @shop.purchases.where(payed: true, payed_out: false)
    @new_purchases_count = @new_purchases.count - (Rails.cache.fetch("#{current_user.id}_last_seen_product_count").to_i)
    Rails.cache.write("#{current_user.id}_last_seen_product_count", @new_purchases.count)
    @credit = BillValueCalculator.calculate(@new_purchases, true).round(2)
    @undelivered_products = @shop.purchases.where(payed: true, shiped: false).count
    @comments = @shop.comments.order('created_at DESC').limit(10)
  end

  def my_bids
    @product_bids = current_user.bids.joins(:product).order('accepted_at DESC')
    @new_accepted_bid_count = current_user.bids.accepted.count - Rails.cache.fetch("#{current_user.id}/last_seen_accepted_bid_count").to_i
    Rails.cache.write("#{current_user.id}/last_seen_accepted_bid_count", current_user.bids.accepted.count)
  end

  def inventory
    @products = @shop.products.order('created_at DESC').map{ |product|
        product_attributes(product)
    }
  end

  def open_bids
    @product_bids = ::Bid.not_accepted.last_on_top.where(product_id: @shop.products.pluck(:id))
    @new_bid_count = @product_bids.count - (Rails.cache.fetch("#{current_user.id}/last_seen_bid_count").to_i)
    Rails.cache.write("#{current_user.id}/last_seen_bid_count", @product_bids.count)
  end

  def past_purchases
    @product_bids = ::Bid.accepted.order('accepted_at DESC').where(product_id: @shop.products.pluck(:id))
  end

  def edit
    
  end

  def create
  	@shop = Shop.new(shop_params)
  	@shop.user_id = current_user.id
  	if @shop.save
  	  redirect_to seller_shops_path
  	else
  	  render 'new'
  	end
  end

  def update
    if @shop.update_attributes(shop_params)
      redirect_to seller_shop_inventory_path
    else 
      render 'edit'
    end

  end

  def destroy
    @shop.update_attributes(deleted: true)
    @shop.products.update_all(deleted: true)
  end
  protected
  def set_shop
    @shop = current_user.shops.find_by_permalink(params[:id])
  end

  def set_current_shop
    @shop = current_user.shops.find_by_permalink(params[:shop_id])
  end

  layout 'shop'
  private

  def check_subscription
    subscription = current_user.subscription
    if current_user.usertype != "admin" && have_accepted_bids && !Time.now.between?(subscription.start_time, subscription.end_time)
      render 'subscribe_link', layout: false
    end
  end

  def have_accepted_bids
    Action.where(user_id: current_user.id, action_type: 'accept_bid').count > 0
  end

  def shop_params
  	params.require(:shop).permit(:name,:description,:phone_number, :email, :address, :pincode, :lat, :lng, :banner)
  end
end