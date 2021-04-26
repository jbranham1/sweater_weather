class ForecastFacade
  def self.get_forecast(location)
    coords = MapquestService.find_coordinal_location(location)
    coords = coords[:results].first[:locations].first[:latLng]
    Forecast.new(WeatherService.find_weather(coords))
  end
end
