class Bid < ActiveRecord::Base
  validates :amount, presence: true
  validates :quantity, presence: true
  belongs_to :product
  scope :last_on_top, -> { order('created_at DESC') }
  scope :accepted, -> { where accepted: true }
  scope :not_accepted, -> { where accepted: false }
end
