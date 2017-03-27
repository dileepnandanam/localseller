class BillValueCalculator
  def self.calculate(bill)
    total = bill.purchases.map{ |p| p.product.price * p.quantity }.sum
    total
  end
end