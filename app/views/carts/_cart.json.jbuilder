json.extract! cart, :id, :total, :created_at, :updated_at
json.url cart_url(cart, format: :json)
