class Product < ApplicationRecord
  belongs_to :brand
  has_many :order_items

  validates :name, presence: true
  validates :sku, presence: true, uniqueness: true
  validates :price_cents, presence: true, numericality: { greater_than: 0 }
  validates :alcohol_by_volume, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
