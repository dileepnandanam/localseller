class PurchasePriceCalculator
  def self.calculate(shoping_tcart)
    total = shoping_tcart.purchases.map{ |p| p.product.price * p.quantity }.sum
    after_purchase_total = total + 3 + total * 2 /100
    after_payout_total = after_purchase_total + 3 + after_purchase_total * 2 /100
    after_payout_total + 3 #our profit
  end
end