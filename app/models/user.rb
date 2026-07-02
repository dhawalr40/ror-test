class User < ApplicationRecord
  has_secure_password

  has_many :orders, dependent: :destroy

  # enum role: { customer: 0, admin: 1 }

  validates :email, presence: true, uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :full_name, presence: true
end
