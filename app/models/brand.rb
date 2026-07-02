class Brand < ApplicationRecord
  CATEGORIES = %w[beer wine spirits soft_drink juice].freeze
  has_many :products, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :country_of_origin, presence: true
end
