class Seller::ShopsController < SellerController
  before_action :set_shop, only: [:edit, :update, :show]

  def new
    redirect_to seller_shop_path if current_user.shop.present?
    @shop = Shop.new
    @shop.user_id = current_user.id
  end

  def show
  	
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
  	params.require(:shop).permit(:name,:description,:phone_number, :email, :pincode, :lat, :lngt, :banner)
  end
end