json.array!(@clients) do |client|
  json.extract! client, :id, :first_name, :first_last_name, :sex, :age
  json.url client_url(client, format: :json)
end
