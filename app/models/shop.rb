class Shop < ActiveRecord::Base
  default_scope { where('deleted = false') }
  
  has_attached_file :banner, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  
  validates_attachment_content_type :banner, content_type: /\Aimage\/.*\z/
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :phone_number, presence: true, numericality: { only_integer: true }
  validates :pincode, presence: true, numericality: { only_integer: true }
  
  has_many :products
  has_many :purchases
  has_many :shoping_carts
  before_save :set_permalink

  acts_as_geolocated
  
  def to_param
    permalink
  end
  
  def set_permalink
  	self.permalink = self.name.underscore
  end
end
