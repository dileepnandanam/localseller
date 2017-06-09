class Bill < ActiveRecord::Base
  has_many :purchases
end
