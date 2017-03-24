class Purchase < ActiveRecord::Base
  belongs_to :product
  belongs_to :shoping_cart
  belongs_to :user
end
