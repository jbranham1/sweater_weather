require 'rails_helper'

RSpec.describe 'Forecast Facade'do
  describe 'get_forecast' do
    it 'can return the forecast from a city and state search' do
      VCR.use_cassette "forecast" do
        location = "denver,co"
        forecast = ForecastFacade.get_forecast(location)

        expect(forecast).to be_a(Forecast)
         expect(forecast.current_weather).to be_a CurrentWeather
         expect(forecast.daily_weather.first).to be_an DailyWeather
         expect(forecast.hourly_weather.first).to be_an HourlyWeather

        current_weather = forecast.current_weather
        expect(DateTime.parse(current_weather.datetime)).to be_a DateTime
        expect(current_weather.sunrise).to be_a String
        expect(DateTime.parse(current_weather.sunrise)).to be_a DateTime
        expect(current_weather.sunset).to be_a String
        expect(DateTime.parse(current_weather.sunset)).to be_a DateTime
        expect(current_weather.temperature).to be_a Float
        expect(current_weather.feels_like).to be_a Float
        expect(current_weather.humidity).to be_a Numeric
        expect(current_weather.uvi).to be_a Numeric
        expect(current_weather.visibility).to be_a Numeric
        expect(current_weather.conditions).to be_a String
        expect(current_weather.icon).to be_a String


        daily_weather = forecast.daily_weather
        expect(daily_weather.count).to eq(5)

        day = daily_weather.first
        expect(day).to be_a DailyWeather

        expect(day).to be_a DailyWeather
        expect(day.date).to be_a Date
        expect(day.sunrise).to be_a String
        expect(DateTime.parse(day.sunrise)).to be_a DateTime
        expect(day.sunset).to be_a String
        expect(DateTime.parse(day.sunset)).to be_a DateTime
        expect(day.max_temp).to be_a Float
        expect(day.min_temp).to be_a Float
        expect(day.conditions).to be_a String
        expect(day.icon).to be_a String


        hourly_weather = forecast.hourly_weather
        expect(hourly_weather.count).to eq(8)

        hour = hourly_weather.first
        expect(hour).to be_a HourlyWeather
        expect(hour).to be_a HourlyWeather
        expect(DateTime.parse(hour.time)).to be_a DateTime
        expect(hour.temperature).to be_a Float
        expect(hour.conditions).to be_a String
        expect(hour.icon).to be_a String

      end
    end
  end
end
