class WeatherService
  def self.find_weather(location)
    params = {
      appid: ENV['OPENWEATHER_KEY'],
      lat: location[:lat],
      lon: location[:lng]
    }
    response = connection.get("onecall?") do |req|
      req.headers["CONTENT_TYPE"] = "application/json"
      req.params = params
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    Faraday.new(url: 'https://api.openweathermap.org/data/2.5/')
  end
end
