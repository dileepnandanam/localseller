class PurchasePriceCalculator
  def initialize(purchases)
    @purchases = purchases
  end

  def calculate
    @purchases.group_by(&:shop).each do |shop, purchases|
      set_purchases_with_delivery_charges(shop, purchases)
    end
  end

  def set_purchases_with_delivery_charges(shop, purchases)
    purchases.each do |purchase| 
      purchase.update_attributes(price: purchase.product.price * purchase.quantity + delivery_charge(shop, purchase, purchases))
    end
  end

  def delivery_charge(shop, purchase, purchases)
    if purchase.product.deliverable
      40/purchases.count
    else
      0
    end
  end
end