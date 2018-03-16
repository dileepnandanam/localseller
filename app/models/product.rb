class Product < ActiveRecord::Base
  default_scope { where('deleted = false') }
  has_attached_file :image, styles: { large: "600x600#", medium: "300x300#", thumb: "100x100#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :unit, presence: true
  before_save :add_searchable
  belongs_to :shop
  has_many :bids, dependent: :destroy
  def add_searchable
  	self.searchable = self.name.downcase
  end
end
