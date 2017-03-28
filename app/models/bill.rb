class Bill < ActiveRecord::Base
  has_many :purchases
  has_many :shoping_carts
end
