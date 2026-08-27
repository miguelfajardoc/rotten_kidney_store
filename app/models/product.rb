class Product < ApplicationRecord
  belongs_to :character
  belongs_to :product_kind

  has_many_attached :images
end
