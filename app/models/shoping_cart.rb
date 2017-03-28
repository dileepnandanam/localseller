class ShopingCart < ActiveRecord::Base
  has_many :purchases
  belongs_to :user
  belongs_to :shop
  belongs_to :bill
end
