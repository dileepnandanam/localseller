class BillValueCalculator
  def self.calculate(shoping_carts, final_price)
      price = shoping_carts.map do |cart| 
        base_price = cart.price
        base_price = base_price - base_price*2/100 -3 #instamojo takes
        base_price = base_price - 3 #we takes
      end.sum
      price = price - price*2/100 -3 if final_price #instamojo takes on bulk checkout
      price = 0 if price == -3
      price
  end
end