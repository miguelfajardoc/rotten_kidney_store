class Product < ApplicationRecord
  belongs_to :character
  belongs_to :product_kind
end
