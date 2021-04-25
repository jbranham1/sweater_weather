class ImageFacade
  def self.get_image(location)
    image = UnsplashService.find_image(location)
    return image if image == {}
    OpenStruct.new({
                    location: location.titleize,
                    image_url: image[:results].first[:urls][:regular],
                    description: image[:results].first[:description],
                    credit: get_credit(image[:results].first)
                  })
  end

  def self.get_credit(image_results)
    {
      source: "unsplash.com",
      author: image_results[:user][:username],
      author_profile: image_results[:user][:links][:html]
    }
  end
end
