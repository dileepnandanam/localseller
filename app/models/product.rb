class Product < ActiveRecord::Base
  default_scope { where('deleted = false') }
  has_attached_file :image, styles: { medium: "300x300#", thumb: "100x100#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates :name, presence: true
  before_save :add_searchable
  def add_searchable
  	self.searchable = self.name.downcase
  end
end
