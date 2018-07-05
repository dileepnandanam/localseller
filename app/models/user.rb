class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  FreeSubscriptionPeriod = 3.months
  after_create :subscribe
  has_one :subscription
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable
  has_one :auth_hash
  has_many :shops
  has_many :shoping_carts
  has_many :bids
  accepts_nested_attributes_for :auth_hash

  validate :uniq_email_across_confirmed
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true, numericality: { only_integer: true }
  validates :pincode, presence: true, numericality: { only_integer: true }
  
  validates :password, presence: true, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?
  validates :password, confirmation: true, if: :password_required?

  acts_as_geolocated
  def uniq_email_across_confirmed
    if User.where('confirmed_at IS NOT NULL AND email = ?', self.email).first.present?
      errors.add :email, 'Email has already been taken'
    end
  end
  def admin?
    usertype == 'admin'
  end
  protected
  def password_required?
  	return false if auth_hash.present?
    true
  end
  def subscribe
    Subscription.create(start_time: Time.now, end_time: (Time.now + FreeSubscriptionPeriod), user_id: self.id)
  end
end
