class BillValueCalculator
  def self.calculate(shoping_carts, final_price=false)
    price = shoping_carts.map do |cart|
      price = cart.price
    end.sum

    price = price - price*2/100 -3 if final_price #instamojo takes on bulk checkout
    price = 0 if price == -3
    price
  end
end