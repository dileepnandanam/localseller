class Platform::ShopsController < PlatformController
  before_action :set_shop, only: [:purchases, :edit, :destroy, :show, :update]
  def purchases
    
    @purchases = @shop.purchases.where(payed: true, payed_out: false)
  end

  def show
    @products = @shop.products
  end
  def index
    @shops = ::Shop.joins(:purchases).
            where(purchases:{payed_out: false, payed: true}).
            group(:shop_id, 'shops.name', 'shops.id').
            select('shops.name, count(purchases.id) as purchase_count, shops.id')
    @all_shops = Shop.all
  end

  def search
    @shops = Shop.where("name LIKE '%#{params[:query]}%'")
    render 'shops', layout: false
  end
  
  def edit
    render 'edit'
  end

  def update
    if @shop.update_attributes(shop_params)
      redirect_to platform_shop_path(@shop)
    else 
      render 'edit'
    end

    def destroy
      @shop.upfate_attributes(deleted: true)
      redirect_to platform_shops_path
    end

  end
  protected
  def shop_params
    params.require(:shop).permit(:name,:description,:phone_number, :email, :pincode, :lat, :lngt, :banner)
  end
  def set_shop
    @shop = ::Shop.find(params[:id])
  end
end