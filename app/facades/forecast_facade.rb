class ForecastFacade
  def self.get_forecast(location)
    coords = MapquestService.find_coordinal_location(location)
    coords = coords[:results].first[:locations].first[:latLng]
    forecast = WeatherService.find_weather(coords)

    return forecast = {} if forecast == {}
    OpenStruct.new({id: nil,
                    current_weather: get_current_weather(forecast[:current]),
                    daily_weather:   {},
                    hourly_weather:  {} })
  end


  def self.get_current_weather(current)
    {
      datetime:     Time.at(current[:dt]).strftime("%F"),
      sunrise:      Time.at(current[:sunrise]).to_datetime,
      sunset:       Time.at(current[:sunset]).to_datetime,
      temperature:  current[:temp],
      feels_like:   current[:feels_like],
      humidity:     current[:humidity],
      uvi:          current[:uvi],
      visibility:   current[:visibility],
      conditions:   current[:weather].first[:description],
      icon:         current[:weather].first[:description]
    }
  end


  def self.get_daily_weather(current)
    # return current = {} if current == {}
    # OpenStruct.new({ datetime: Time.at(current[:datetime]).to_datetime,
    #                  sunrise:   current[:sunrise],
    #                  sunset:  current[:sunset],
    #                  temperature:  current[:temperature],
    #                  feels_like:  current[:feels_like],
    #                  humidity:  current[:humidity],
    #                  uvi:  current[:uvi],
    #                  visibility:  current[:visibility],
    #                  conditions:  current[:conditions].first[:description],
    #                  icon:  current[:icon].first[:description]})
  end

  def self.get_hourly_weather(current)
    # return current = {} if current == {}
    # OpenStruct.new({ current_weather: get_current_weather(forecast[:current]),
    #                  daily_weather:   get_daily_weather(forecast[:daily]),
    #                  hourly_weather:  get_hourly_weather(forecast[:hourly]) })
  end
end
