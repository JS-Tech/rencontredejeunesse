json.array! @testimonies do |testimony|
  json.id testimony.id
  json.message testimony.message
  json.author testimony.user.full_name
end