class ImageFacade
  def self.get_image(location)
    image = UnsplashService.find_image(location)
    Image.new(image, location)
  end
end
