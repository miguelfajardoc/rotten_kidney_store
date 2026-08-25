class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.integer :stock
      t.decimal :price
      t.decimal :cost
      t.string :aditional_info
      t.references :character, null: false, foreign_key: true
      t.references :product_kind, null: false, foreign_key: true

      t.timestamps
    end
  end
end
