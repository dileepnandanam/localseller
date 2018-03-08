class Seller::ShopsController < SellerController
  before_action :set_shop, only: [:edit, :update, :show]
  before_action :set_current_shop, only: [:inventory, :past_purchases, :open_bids]

  def new
    @shop = Shop.new
    @shop.user_id = current_user.id
  end

  def index
    @shops = current_user.shops
  end

  def show
  	@new_purchases = @shop.purchases.where(payed: true, payed_out: false)
    @new_purchases_count = @new_purchases.count - (Rails.cache.fetch("#{current_user.id}_last_seen_product_count") || 0)
    Rails.cache.write("#{current_user.id}_last_seen_product_count", @new_purchases.count)
    @credit = BillValueCalculator.calculate(@new_purchases, true).round(2)
    @undelivered_products = @shop.purchases.where(payed: true, shiped: false).count
    @comments = @shop.comments.order('created_at DESC').limit(10)
  end

  def my_bids
    render 'my_bids'
  end

  def inventory
    @products = @shop.products.order('created_at DESC').map{ |product|
        product_attributes(product)
    }
  end

  def open_bids

  end

  def past_purchases

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

  def shop_params
  	params.require(:shop).permit(:name,:description,:phone_number, :email, :address, :pincode, :lat, :lng, :banner)
  end
end