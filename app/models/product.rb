class Product < ApplicationRecord
  belongs_to :character
  belongs_to :product_kind

  has_many_attached :images

  def title
    [ character&.name, product_kind&.name ].compact.join(" ").presence || "Product ##{id}"
  end

  def sold_out?
    stock.to_i <= 0
  end
end
