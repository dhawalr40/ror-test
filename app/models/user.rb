class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  # enum role: { customer: 0, admin: 1 }
  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true
end
