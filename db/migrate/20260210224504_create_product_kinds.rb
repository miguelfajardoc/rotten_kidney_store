class CreateProductKinds < ActiveRecord::Migration[8.0]
  def change
    create_table :product_kinds do |t|
      t.string :name
      t.string :material
      t.string :description

      t.timestamps
    end
  end
end
