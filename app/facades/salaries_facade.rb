class SalariesFacade
  def self.get_salaries(destination)
    salaries = TeleportService.find_salaries(destination)
    coords = MapquestService.find_coordinal_location(destination)
    coords = coords[:results].first[:locations].first[:latLng]
    forecast = WeatherService.find_weather(coords)

    Salaries.new(salaries, forecast, destination)
  end
end
