class PurchasePriceCalculator
  def self.calculate(shoping_tcart)
    total = shoping_tcart.purchases.map{ |p| p.product.price * p.quantity }.sum
  end
end