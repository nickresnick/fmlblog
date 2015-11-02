json.array!(@topics) do |topic|
  json.extract! topic, :id, :post_id, :user_id, :name
  json.url topic_url(topic, format: :json)
end
