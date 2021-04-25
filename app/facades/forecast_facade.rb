class ForecastFacade
  def self.get_forecast(location)
    coords = MapquestService.find_coordinal_location(location)
    coords = coords[:results].first[:locations].first[:latLng]
    forecast = WeatherService.find_weather(coords)

    return forecast if forecast == {}
    OpenStruct.new({
                    current_weather: get_current_weather(forecast[:current]),
                    daily_weather:   get_daily_weather(forecast[:daily]),
                    hourly_weather:  get_hourly_weather(forecast[:hourly]) })
  end


  def self.get_current_weather(current)
    {
      datetime:     Time.at(current[:dt]).strftime("%F %T %z"),
      sunrise:      Time.at(current[:sunrise]).strftime("%F %T %z"),
      sunset:       Time.at(current[:sunset]).strftime("%F %T %z"),
      temperature:  current[:temp],
      feels_like:   current[:feels_like],
      humidity:     current[:humidity],
      uvi:          current[:uvi],
      visibility:   current[:visibility],
      conditions:   current[:weather].first[:description],
      icon:         current[:weather].first[:icon]
    }
  end


  def self.get_daily_weather(daily)
    daily.map do |day|
      {
        date:        Time.at(day[:dt]).to_date,
        sunrise:     Time.at(day[:sunrise]).strftime("%F %T %z"),
        sunset:      Time.at(day[:sunset]).strftime("%F %T %z"),
        max_temp:    day[:temp][:max],
        min_temp:    day[:temp][:min],
        conditions:  day[:weather].first[:description],
        icon:        day[:weather].first[:icon]
      }
    end.first(5)
  end

  def self.get_hourly_weather(hourly)
    hourly.map do |hour|
      {
        time:         Time.at(hour[:dt]).strftime("%T"),
        temperature:  hour[:temp],
        conditions:   hour[:weather].first[:description],
        icon:         hour[:weather].first[:icon]
      }
    end.first(8)
  end
end
