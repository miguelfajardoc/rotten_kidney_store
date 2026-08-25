class CreateJoinTableProductKindsSizes < ActiveRecord::Migration[8.0]
  def change
    create_join_table :product_kinds, :sizes do |t|
      t.index [:product_kind_id, :size_id]
      t.index [:size_id, :product_kind_id]
    end
  end
end
