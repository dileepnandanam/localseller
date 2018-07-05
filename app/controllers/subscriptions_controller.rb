class SubscriptionsController < ApplicationController
  def new
    subscription = current_user.subscription
    payment_request = InstamojoHandler.client.payment_request({
      amount: 100,
      purpose: 'Subscribe',
      send_email: true,
      email: current_user.email,
      redirect_url: subscription_payed_url(subscription)
    })
    payment_request.reload!
    subscription.update_attributes(im_payment_request_id: payment_request.original["id"])
    @payment_url = payment_request.original["longurl"]
  end

  def payed
    subscription = current_user.subscription
    if params[:payment_request_id] == subscription.im_payment_request_id
      subscription.update_attributes(start_time: Time.now, end_time: (time.now + 1.years))
    end
  end
end