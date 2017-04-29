class Seller::ProductsController < Seller::ShopsController
  before_action :set_shop
  before_action :set_product, only: [:show, :update, :edit, :destroy, :image_upload]
  def new
    @product = Product.new
    @product.shop_id = @shop.id
    render 'seller/shops/products/new'
  end

  def index
    @products = @shop.products.order(:created_at).map{ |product|
      {
        name: product.name,
        price: product.price,
        shop_id: product.shop_id,
        image_filename: product.image.original_filename,
        image_url: product.image.url(:medium),
        unit: product.unit,
        id: product.id,
        update_url: seller_shop_product_path(product),
        image_uploaded: product.image.present?,
        image_upload_url:  image_upload_seller_shop_product_path(product),
        delete_url:  seller_shop_product_path(product)
      }
    }
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
  def image_upload
    @product.update_attributes(product_imade_params)
    render json: {image_url: @product.image.url(:medium)}.to_json
  end
  def update
    if @product.update_attributes(product_params)
      redirect_to seller_shop_products_path
    else
      render 'seller/shops/products/edit'
    end
  end
  protected
  def product_imade_params
    params.permit(:image)
  end
  def set_product
    @product = @shop.products.find(params[:id])
  end
  def product_params
    params.require(:product).permit(:name, :price, :unit)
  end
end