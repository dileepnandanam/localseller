class ShopingCartsController < ApplicationController
  def checkout
    @shoping_cart = ShopingCart.find(session[:shoping_cart_id])
    @shoping_cart.update_attributes(user_id: current_user.id)
    @shoping_cart.purchases.each{|purchase| purchase.update_attributes(user_id: current_user.id)}
    payment_request = InstamojoHandler.client.payment_request({
      amount: @shoping_cart.price,
      purpose: 'Product payment',
      send_email: true,
      email: current_user.email,
      redirect_url: payed_shoping_cart_url(@shoping_cart)
    })
    payment_request.reload!
    @shoping_cart.update_attributes(im_payment_request_id: payment_request.original["id"])

    redirect_to payment_request.original["longurl"]
  end


  def add_to_cart
    if session[:shoping_cart_id] && ShopingCart.find_by_id(session[:shoping_cart_id])
      shoping_cart = ShopingCart.find_by_id(session[:shoping_cart_id])
    else
      shoping_cart = ShopingCart.create
      session[:shoping_cart_id] = shoping_cart.id
    end

    purchase = shoping_cart.purchases.create(purchase_params)
    render json: {id: purchase.id}
  end

  def current_cart
    if session[:shoping_cart_id]  
      shoping_cart = ShopingCart.find(session[:shoping_cart_id])
      
      render json: shoping_cart.purchases.map{|purchase| 
        {
          name: purchase.product.name,
          quantity: purchase.quantity,
          product_id: purchase.product.id,
          unit: purchase.product.unit,
          id: purchase.id
        }
      }.to_json
    else
      render json: [].to_json
    end
  end

  def remove_purchase
    purchase = Purchase.find(params[:id])
    shoping_cart = purchase.shoping_cart
    purchase.delete
    unless shoping_cart.purchases.present?
      shoping_cart.delete
    end
    render head: :ok, nothing: true
  end

  def payed
    @shoping_cart = ShopingCart.find(params[:id])
    if params[:payment_request_id] == @shoping_cart.im_payment_request_id
      @shoping_cart.update_attributes(im_payment_id: params[:payment_id])
      @shoping_cart.purchases.each do |purchase|
        purchase.update_attributes(payed: true)
      end
      @shoping_cart.update_attributes(checked_out: true)
    end
    session.delete(:shoping_cart_id)
    flash[:notice] = 'Payment successfull'
    redirect_to root_path
  end

  protected
  def purchase_params
    params.permit(:quantity, :product_id, :shop_id)
  end
  def shoping_cart_params
    params.require(:purchases)
  end
end