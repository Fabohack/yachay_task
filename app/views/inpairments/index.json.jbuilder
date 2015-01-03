json.array!(@inpairments) do |inpairment|
  json.extract! inpairment, :id, :description
  json.url inpairment_url(inpairment, format: :json)
end
