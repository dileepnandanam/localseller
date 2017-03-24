class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable
  has_one :auth_hash
  has_one :shop
  accepts_nested_attributes_for :auth_hash

  validates :email, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true, numericality: { only_integer: true }
  validates :pincode, presence: true, numericality: { only_integer: true }
  
  validates :password, presence: true, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?
  validates :password, confirmation: true, if: :password_required?

  def admin?
    usertype == 'admin'
  end
  protected
  def password_required?
  	return false if auth_hash.present?
    true
  end
end
