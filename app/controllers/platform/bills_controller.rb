class Platform::BillsController < Platform::ShopsController
  before_action :set_shop, only: [:show, :create]
  before_action :setup_instamojo, only: [:show, :payed]
  
  def create
    @purchases = @shop.purchases.where(payed: true, payed_out: false)
    @bill = Bill.create
    @bill.purchases = @purchases
    @bill.save
    @total = BillValueCalculator.calculate(@purchases, final_price=true)
    render 'platform/shops/bills/create'
  end

  def show
    @bill = Bill.find(params[:id])

    payment_request = @im_client.payment_request({
      amount: BillValueCalculator.calculate(@shop.purchases),
      purpose: 'seller payment',
      send_email: true,
      email: current_user.email,
      redirect_url:  payed_platform_shop_bill_url(@shop, @bill)
    })
    payment_request.reload!
    @bill.update_attributes(im_payment_request_id: payment_request.original["id"])
    redirect_to payment_request.original["longurl"]
  end

  def payed
    @bill=Bill.find(params[:id])
    if params[:payment_request_id] == @bill.im_payment_request_id
      @bill.update_attributes(im_payment_id: params[:payment_id])
      @bill.purchases.each do |purchase|
        purchase.update_attributes(payed_out: true)
      end
      @bill.shoping_carts.each do |cart|
        cart.update_attributes(payed_out: true)
      end
    end
  end
  protected

  def setup_instamojo
    api = Instamojo::API.new(@shop.instamajo_api_key, @shop.instamajo_auth_token)
    @im_client = api.client
  end
  def set_shop
    @shop = ::Shop.find_by_permalink(params[:shop_id])
  end
end
