class PurchasePriceCalculator
	def self.calculate(cart)
		total = cart.purchases.map{ |purchase| purchase.product.price*purchase.quantity}.sum
		with_im_charge = total + instamojo_charge(total)
		with_im_charge = with_im_charge + 3
		with_im_charge
	end

	def self.instamojo_charge(price)
		price*2/100+3
	end
end

