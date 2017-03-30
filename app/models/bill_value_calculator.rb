class BillValueCalculator
  def self.calculate(shoping_carts)
      shoping_carts.map do |cart| 
        base_price = cart.purchases.map{|p| p.product.price }.sum
        base_price -3
      end.sum
  end
end