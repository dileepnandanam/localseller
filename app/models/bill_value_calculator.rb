class BillValueCalculator
  def self.calculate(purchases, final_price=false)
    price = purchases.map do |purchase|
      purchase.product.price*purchase.quantity - purchase.product.price*purchase.quantity*2/100 -6*shoping_cart_fraction(purchase)
    end.sum

    if final_price
      final_price =  price - price*2/100 - 3
      return final_price < 0 ? 0 : final_price
    end
    return price
  end
  def self.shoping_cart_fraction(purchase)
    total = purchase.shoping_cart.price
  	price = purchase.product.price * purchase.quantity
  	price/total
  end
end