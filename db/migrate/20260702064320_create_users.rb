class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :full_name, null: false
      t.integer :role, null: false, default: 0
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
