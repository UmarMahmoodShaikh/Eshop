json.extract! shopper, :id, :name, :email, :pass, :phone, :created_at, :updated_at
json.url shopper_url(shopper, format: :json)
