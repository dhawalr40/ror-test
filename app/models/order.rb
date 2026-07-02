class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :total_cents, numericality: { greater_than_or_equal_to: 0 }
end
