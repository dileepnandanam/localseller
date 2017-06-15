class ShopingCart < ActiveRecord::Base
  has_many :purchases
  belongs_to :user
  belongs_to :shop

  def set_price
    PurchasePriceCalculator.new(purchases).calculate
  end
  def price
  	purchases.map{ |p| p.price }.sum
  end

  def shipped
  	purchases.map(&:shipped).unieqe == true
  end
end
