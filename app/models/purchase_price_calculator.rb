class PurchasePriceCalculator
  def self.calculate(shoping_cart)
    total = shoping_tcart.purchases.map{ |p| p.product.price * p.quantity }.sum,
    after_instamojo_charges = total + instamojo_charge(total)
    after_lototribe_charges = after_instamojo_charges + 3
  end

  def instamojo_charge(price)
  	price*2/100 + 3
  end
end