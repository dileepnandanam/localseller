class Bid < ActiveRecord::Base
  belongs_to :product
  scope :accepted, -> { where accepted: true }
  scope :not_accepted, -> { where accepted: false }
end
