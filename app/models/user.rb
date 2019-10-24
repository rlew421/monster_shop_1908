class User < ApplicationRecord
  has_many :orders
  
  validates_presence_of :name, :address, :city, :state, :zip
  validates :email, uniqueness: true, presence: true

  validates :password, :presence => true, allow_nil: false

  has_secure_password

  enum role: %w(default merchant_employee merchant_admin admin)
end
