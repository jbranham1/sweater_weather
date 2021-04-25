class MapquestService
  def self.find_coordinal_location(location)
    location_params = {
      key: ENV['MAPQUEST_KEY'],
      location: location
    }
    response = connection.get("/geocoding/v1/address?") do |req|
      req.headers["CONTENT_TYPE"] = "application/json"
      req.params = location_params
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.find_directions(origin, destination)
    location_params = {
      key: ENV['MAPQUEST_KEY'],
      from: origin,
      to: destination
    }
    response = connection.get("/directions/v2/route?") do |req|
      req.headers["CONTENT_TYPE"] = "application/json"
      req.params = location_params
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    Faraday.new(url: 'http://www.mapquestapi.com')
  end
end
