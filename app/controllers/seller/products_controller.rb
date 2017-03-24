class Seller::ProductsController < Seller::ShopsController
  before_action :set_shop
  before_action :set_product, only: [:show, :update, :edit, :destroy]
  def new
    @product = Product.new
    @product.shop_id = @shop.id
    render 'seller/shops/products/new'
  end

  def index
    @products = @shop.products
    render 'seller/shops/products/index'
  end

  def create
    @product = Product.new(product_params)
    @product.shop_id = @shop.id
    if @product.save
      redirect_to seller_shop_products_path
    else
      render 'seller/shops/products/new'
    end
  end

  def edit
    render 'seller/shops/products/edit'
  end

  def destroy
    @product.update_attributes deleted: true
    redirect_to seller_shop_products_path
  end

  def update
    if @product.update_attributes(product_params)
      redirect_to seller_shop_products_path
    else
      render 'seller/shops/products/edit'
    end
  end
  protected
  def set_product
    @product = @shop.products.find(params[:id])
  end
  def product_params
    params.require(:product).permit(:name, :description, :price, :image)
  end
end