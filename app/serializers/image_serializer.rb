class ImageSerializer
  include FastJsonapi::ObjectSerializer
  set_id :id
  attributes :location, :image_url, :description, :credit
end
