class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attribute :current_weather do |object|
    CurrentWeather.new(object.current_weather)
  end

  attribute :daily_weather do |object|
    DailyWeather.new(object.daily_weather)
  end

  attribute :hourly_weather do |object|
    HourlyWeather.new(object.hourly_weather)
  end
end
