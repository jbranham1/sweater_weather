class Forecast
  attr_reader :id,
              :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(data)
    @id = nil
    @current_weather = CurrentWeather.new(data[:current])
    @daily_weather = get_daily_weather(data[:daily])
    @hourly_weather = get_hourly_weather(data[:hourly])
  end

  def get_daily_weather(daily)
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

  def get_hourly_weather(hourly)
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
