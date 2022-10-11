json.extract! retailer, :id, :name, :email, :pass, :phone, :address, :created_at, :updated_at
json.url retailer_url(retailer, format: :json)
