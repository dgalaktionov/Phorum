json.array!(@admins) do |admin|
  json.extract! admin, :id
  json.url admin_url(admin, format: :json)
end
