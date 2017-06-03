class Platform::ShopsController < PlatformController
  before_action :set_shop, only: [:purchases, :edit, :destroy, :show, :update]
  def purchases
    
    @purchases = @shop.purchases.where(payed: true, payed_out: false, shiped: true)
  end

  def show
    @products = @shop.products
  end
  def index
    @shops = ::Shop.joins(:purchases).
            where(purchases:{payed_out: false, payed: true, shiped: true}).
            group('shops.name', 'shops.id').
            select('shops.name as name, count(purchases.id) as purchase_count, shops.id as id, shops.permalink as permalink')

    @all_shops = Shop.all.limit(10)
    @shop_count = Shop.count
    
  end

  def search
    @all_shops = Shop.where("name LIKE '%#{params[:query]}%'")
    render 'shops', layout: false
  end
  def new
    @shop = Shop.new
    render 'new'
  end
  def create
    @shop = Shop.new(shop_params)
    if @shop.save
      redirect_to platform_shops_path
    else
      render 'new'
    end
  end
  def edit
    render 'edit'
  end

  def update
    if @shop.update_attributes(shop_params)
      redirect_to platform_shop_products_path(@shop)
    else 
      render 'edit'
    end
  end
  def destroy
    @shop.update_attributes(deleted: true)
    redirect_to platform_shops_path
  end
  protected
  def shop_params
    params.require(:shop).permit(:name,:description,:phone_number, :email, :pincode, :lat, :lng, :banner)
  end
  def set_shop
    @shop = ::Shop.find_by_permalink(params[:id])
  end
end