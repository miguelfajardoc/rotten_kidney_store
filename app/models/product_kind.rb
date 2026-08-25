class ProductKind < ApplicationRecord
    has_many :product_kind_sizes
    has_many :sizes, through: :product_kind_sizes
end
