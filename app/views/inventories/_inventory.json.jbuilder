json.extract! inventory, :id, :price, :category, :description, :created_at, :updated_at
json.url inventory_url(inventory, format: :json)
