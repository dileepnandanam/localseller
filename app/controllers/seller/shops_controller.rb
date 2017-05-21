class Seller::ShopsController < SellerController
  before_action :set_shop, only: [:edit, :update, :show]

  def new
    redirect_to seller_shop_path if current_user.shop.present?
    @shop = Shop.new
    @shop.user_id = current_user.id
  end

  def show
  	@new_purchases = @shop.purchases.where(payed: true, payed_out: false)
    @new_purchases_count = @new_purchases.count - (Rails.cache.fetch("#{current_user.id}_last_seen_product_count") || 0)
    Rails.cache.write("#{current_user.id}_last_seen_product_count", @new_purchases.count)
    @credit = BillValueCalculator.calculate(@new_purchases, true).round(2)
    @undelivered_products = @shop.purchases.where(payed: true, shiped: false).count
    @comments = @shop.comments.order('created_at DESC').limit(10)
  end

  def edit
    
  end

  def create
  	@shop = Shop.new(shop_params)
  	@shop.user_id = current_user.id
  	if @shop.save
  	  redirect_to seller_shop_path
  	else
  	  render 'new'
  	end
  end

  def update
    if @shop.update_attributes(shop_params)
      redirect_to seller_shop_path
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
    @shop = current_user.shop
  end
  private

  def shop_params
  	params.require(:shop).permit(:name,:description,:phone_number, :email, :pincode, :lat, :lng, :banner)
  end
end