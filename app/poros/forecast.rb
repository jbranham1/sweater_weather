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
    daily.first(5).map do |day|
      DailyWeather.new(day)
    end
  end

  def get_hourly_weather(hourly)
    hourly.first(8).map do |hour|
      HourlyWeather.new(hour)
    end
  end
end
