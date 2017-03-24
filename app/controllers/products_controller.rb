class ProductsController < ApplicationController
	def index

    render json: product_list_json(ProductQueryHandler.new(params).result)
	end

  protected
  def product_list_json(products)
    products.map {|product|
      { id: product.id, 
        name: product.name,
        price: "Rs #{product.price}",
        description: product.description,
        image: product.image.url(:medium),
        shop_id: product.shop_id
      }
    }.to_json
  end
end