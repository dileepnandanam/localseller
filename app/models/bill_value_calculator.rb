class BillValueCalculator
  def self.calculate(shoping_carts, final_price)
      price = shoping_carts.map do |cart| 
        base_price = cart.purchases.map{|p3| p.product.price }.sum
        base_price - base_price*2/100 -3 -3
      end.sum
      price = price - price*2/100 -3 if final_price
      price = 0 if price == -3
      price
  end
end