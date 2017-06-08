class ShopingCart < ActiveRecord::Base
  has_many :purchases
  belongs_to :user
  belongs_to :shop
  belongs_to :bill
  def price
  	purchases.map{ |p| p.price * p.quantity }.sum
  end

  def shipped
  	purchases.map(&:shipped).unieqe == true
  end
end
