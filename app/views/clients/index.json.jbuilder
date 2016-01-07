json.array!(@clients) do |client|
  json.extract! client, :id, :first_name, :last_first_name, :sex, :age
  json.url client_url(client, format: :json)
end
