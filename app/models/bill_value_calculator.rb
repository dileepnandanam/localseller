class BillValueCalculator
  def self.calculate(shoping_carts, final_price)
      price = shoping_carts.map do |cart| 
        base_price = PurchasePriceCalculator.calculate(cart)
        base_price = base_price - base_price*2/100 -3 -3 #instamojo takes
      end.sum
      price = price - price*2/100 -3 if final_price #instamojo takes on bulk checkout
      price = 0 if price == -3
      price
  end
end