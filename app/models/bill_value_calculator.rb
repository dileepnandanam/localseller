class BillValueCalculator
  def self.calculate(shoping_carts, final_price=false)
    price = shoping_carts.map do |cart|
      cart.price - cart.price*2/100 - 3 -3
    end.sum

    final_price =  price - price*2/100 - 3 if final_price
  end
end