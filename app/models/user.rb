class User < ApplicationRecord
  has_many :orders
  has_many :employments
  has_many :merchants, through: :employments


  validates_presence_of :name, :address, :city, :state, :zip
  validates :email, uniqueness: true, presence: true

  validates :password, :presence => true, allow_nil: false

  has_secure_password

  enum role: %w(default merchant_employee merchant_admin admin)

  def role_upgrade(merchant, new_role)
    self.update_column(:role, new_role)
    Employment.creation(self, merchant)
  end
end
