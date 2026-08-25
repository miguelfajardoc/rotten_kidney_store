json.extract! product, :id, :stock, :price, :cost, :aditional_info, :character_id, :product_kind_id, :created_at, :updated_at
json.url product_url(product, format: :json)
