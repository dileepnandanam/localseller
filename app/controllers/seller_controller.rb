class SellerController < ApplicationController
  layout 'seller'

  protected
  def product_attributes(product)
    {
      name: product.name,
      price: product.price,
      description: product.description,
      shop_id: product.shop_id,
      image_filename: product.image.original_filename,
      image_url: product.image.url(:medium),
      unit: product.unit,
      id: product.id,
      update_url: seller_shop_product_path(@shop, product),
      image_uploaded: product.image.present?,
      image_upload_url:  image_upload_seller_shop_product_path(@shop, product),
      delete_url:  seller_shop_product_path(@shop, product),
      deliverable: product.deliverable,
      quantity: product.quantity
    }
  end
end