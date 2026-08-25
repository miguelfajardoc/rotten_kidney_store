json.extract! product_kind, :id, :name, :material, :description, :created_at, :updated_at
json.url product_kind_url(product_kind, format: :json)
