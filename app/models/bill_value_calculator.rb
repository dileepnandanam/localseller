class BillValueCalculator
  def self.calculate(bill)
    total = bill.purchases.map{ |p| p.product.price * p.quantity }.sum
    total = total - 3 - total*2/100 - 3
  end
end