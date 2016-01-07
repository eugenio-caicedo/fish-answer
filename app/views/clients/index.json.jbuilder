json.array!(@clients) do |client|
  json.extract! client, :id, :firstName, :lastFirstName, :sex, :age
  json.url client_url(client, format: :json)
end
