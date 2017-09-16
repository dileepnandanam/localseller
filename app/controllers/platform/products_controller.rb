class Platform::ProductsController < Platform::ShopsController
  before_action :set_shop
  before_action :set_product, only: [:show, :update, :edit, :destroy, :image_upload]
  def new
    @product = Product.new
    @product.shop_id = @shop.id
    render 'platform/shops/products/new'
  end

  def index
    @products = @shop.products.order('created_at DESC').map{ |product|
        product_attributes(product)
    }
    render 'platform/shops/products/index'
  end

  def create
    @product = Product.new(product_params)
    @product.shop_id = @shop.id
    if @product.save
      render json: product_attributes(@product).to_json
    else
      render json: @product.errors.messages
      .map{|field, errors|  [field, errors.join(', ')]}.to_h, status: 422
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
      render json: @product.errors.messages
      .map{|field, errors|  [field, errors.join(', ')]}.to_h, status: 422
    end
  end
  def image_upload
    @product.update_attributes(product_image_params)
    render json: {image_url: @product.image.url(:medium)}.to_json
  end
  protected
  def product_attributes(product)
    {
      name: product.name,
      price: product.price,
      shop_id: product.shop_id,
      image_filename: product.image.original_filename,
      image_url: product.image.url(:medium),
      unit: product.unit,
      id: product.id,
      update_url: platform_shop_product_path(@shop, product),
      image_uploaded: product.image.present?,
      image_upload_url:  image_upload_platform_shop_product_path(@shop, product),
      delete_url:  platform_shop_product_path(product.shop, product),
      deliverable: product.deliverable,
      quantity: product.quantity
    }  
  end
  def product_image_params
    params.permit(:image)
  end
  def set_product
    @product = @shop.products.find(params[:id])
  end
  def set_shop
  	@shop = Shop.find_by_permalink(params[:shop_id])
  end
  def product_params
    params.require(:product).permit(:name, :description, :price, :image, :unit, :deliverable, :quantity)
  end
end