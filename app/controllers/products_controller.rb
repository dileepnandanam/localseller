class ProductsController < ApplicationController
	def index
    render json: product_list_json(ProductQueryHandler.new(params, current_user).result)
	end

  def for_shop
    @shop = Shop.where(permalink: params[:permalink]).first
    render json: product_list_json(ProductQueryHandler.new(params, current_user, {shop_id: @shop.id}).result)
  end

  def wholesale
    render json: product_list_json(ProductQueryHandler.new(params, current_user, {deliverable: false}).result)
  end

  protected
  def product_list_json(products)
    products.map {|product|
      { id: product.id, 
        name: product.name,
        price: "Rs #{product.price}",
        description: product.description,
        image: product.image.url(:medium),
        large_image: product.image,
        shop_id: product.shop_id,
        shop_url: shop_path(product.shop),
        shop_name: product.shop.name,
        shop_id: product.shop.id,
        unit: product.unit
      }
    }.to_json
  end
end