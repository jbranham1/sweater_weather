class MapquestService
  def self.find_coordinal_location(location)
    location_params = {
      key: ENV['MAPQUEST_KEY'],
      location: location
    }
    response = connection.get("address?") do |req|
      req.headers["CONTENT_TYPE"] = "application/json"
      req.params = location_params
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    Faraday.new(url: 'http://www.mapquestapi.com/geocoding/v1/')
  end
end
