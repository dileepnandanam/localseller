class BillValueCalculator
  def self.calculate(purchases, final_price=false)
    price = purchases.map do |purchase|
      purchase.price - purchase.price*2/100 -6*shoping_cart_fraction(purchase)
    end.sum


    final_price =  price - price*2/100 - 3 if final_price
    final_price == -3 ? 0 : final_price
    
  end
  def shoping_cart_fraction(purchase)
  	total = purchase.shoping_cart.price
  	purchase/total
  end
end