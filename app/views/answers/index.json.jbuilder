json.array!(@answers) do |answer|
  json.extract! answer, :id, :title, :description
  json.url answer_url(answer, format: :json)
end
