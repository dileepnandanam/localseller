class Platform::ProductsController < Platform::ShopsController
  before_action :set_shop
  before_action :set_product, only: [:show, :update, :edit, :destroy]
  def new
    @product = Product.new
    @product.shop_id = @shop.id
    render 'platform/shops/products/new'
  end

  def index
    @products = @shop.products
    render 'platform/shops/products/index'
  end

  def create
    @product = Product.new(product_params)
    @product.shop_id = @shop.id
    if @product.save
      redirect_to platform_shop_products_path(@shop)
    else
      render 'platform/shops/products/new'
    end
  end

  def edit
    render 'platform/shops/products/edit'
  end

  def destroy
    @product.update_attributes deleted: true
    redirect_to platform_shop_products_path
  end

  def update
    if @product.update_attributes(product_params)
      redirect_to platform_shop_products_path
    else
      render 'platform/shops/products/edit'
    end
  end
  protected
  def set_product
    @product = @shop.products.find(params[:id])
  end
  def set_shop
  	@shop = Shop.find_by_permalink(params[:shop_id])
  end
  def product_params
    params.require(:product).permit(:name, :description, :price, :image)
  end
end