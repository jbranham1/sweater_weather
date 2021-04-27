class ImageFacade
  def self.get_image(location)
    return {} if location.empty?
    image = UnsplashService.find_image(location)
    Image.new(image, location)
  end
end
