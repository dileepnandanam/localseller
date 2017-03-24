class ShopingCart < ActiveRecord::Base
  has_many :purchases
  belongs_to :user
end
