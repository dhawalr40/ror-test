class CreateBrands < ActiveRecord::Migration[8.0]
  def change
    create_table :brands do |t|
      t.string :name, null: false
      t.string :country_of_origin, null: false
      t.string :category

      t.timestamps
    end
  end
end
