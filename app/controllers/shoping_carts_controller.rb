class ShopingCartsController < ApplicationController
  def show
    @shoping_cart = ShopingCart.find(params[:id])

    payment_request = InstamojoHandler.client.payment_request({
      amount: PurchasePriceCalculator.calculate(@shoping_cart),
      purpose: 'Product payment',
      send_email: true,
      email: current_user.email,
      redirect_url: payed_shoping_cart_url(@shoping_cart)
    })
    payment_request.reload!
    @shoping_cart.update_attributes(im_payment_request_id: payment_request.original["id"])

    redirect_to payment_request.original["longurl"]
  end

  def create
    @shoping_cart = ShopingCart.create(user_id: current_user.id)
    shoping_cart_params.each do |index, param|
      @shoping_cart.purchases.build(
        product_id: param[:product_id],
        shop_id: param[:shop_id],
        quantity: param[:quantity],
        user_id: current_user.id
      )
    end
    @shoping_cart.save
    render json: {url: shoping_cart_path(@shoping_cart)}
  end

  def payed
    @shoping_cart = ShopingCart.find(params[:id])
    if params[:payment_request_id] == @shoping_cart.im_payment_request_id
      @shoping_cart.update_attributes(im_payment_id: params[:payment_id])
      @shoping_cart.purchases.each do |purchase|
        purchase.update_attributes(payed: true)
      end
    end
    redirect_to root_path
  end

  protected
  def shoping_cart_params
    params.require(:purchases)
  end
end