class PurchasePriceCalculator
	def self.calculate(cart)
		total = cart.purchases.map{ |purchase| purchase.product.price*purchase.quantity}.sum
	end
end

