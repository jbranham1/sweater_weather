class ForecastFacade
  def self.get_forecast(location)
    return {} if location.empty?
    coords = MapquestService.find_coordinal_location(location)
    coords = coords[:results].first[:locations].first[:latLng]
    Forecast.new(WeatherService.find_weather(coords))
  end
end
