json.extract! company, :id, :name, :about, :email, :created_at, :updated_at
json.url company_url(company, format: :json)
