class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.integer :status, null: false, default: 0
      t.integer :total_cents, null: false, default: 0
      t.references :user, null: false, foreign_key: true, index: true
      t.timestamps
    end
  end
end
