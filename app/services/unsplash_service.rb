class UnsplashService
  def self.find_image(location)
    if location.blank?
      location
    else
      location = "#{location} downtown"
    end
    location_params = {
      client_id: ENV['UNSPLASH_KEY'],
      query: location,
      page: 1,
      per_page: 1
    }
    response = connection.get("search/photos?") do |req|
      req.headers["CONTENT_TYPE"] = "application/json"
      req.params = location_params
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    Faraday.new(url: 'https://api.unsplash.com/')
  end
end
