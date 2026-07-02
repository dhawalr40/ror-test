class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :sku, null: false, index: true
      t.integer :price_cents, null: false
      t.decimal :alcohol_by_volume, precision: 5, scale: 2, default: 0.0
      t.integer :stock_quantity, null: false, default: 0
      t.references :brand, :product, index: true, foreign_key: true

      t.timestamps
    end
  end
end
