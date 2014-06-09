json.array!(@items) do |item|
  json.extract! item, :id, :name, :body, :preview
  json.url admin_item_url(item, format: :json)
end
