require 'rails_helper'

RSpec.describe 'Forecast Facade'do
  describe 'get_forecast' do
    it 'can return the forecast from a city and state search' do
      VCR.use_cassette "forecast" do
        location = "denver,co"
        forecast = ForecastFacade.get_forecast(location)

        expect(forecast).to be_a(Forecast)
        expect(forecast.current_weather).to be_a Hash
        expect(forecast.daily_weather).to be_an Array
        expect(forecast.hourly_weather).to be_an Array

        current_weather = forecast.current_weather
        expect(current_weather.count).to eq(10)
        expect(current_weather).to have_key(:datetime)
        expect(DateTime.parse(current_weather[:datetime])).to be_a DateTime
        expect(current_weather).to have_key(:sunrise)
        expect(current_weather[:sunrise]).to be_a String
        expect(DateTime.parse(current_weather[:sunrise])).to be_a DateTime
        expect(current_weather).to have_key(:sunset)
        expect(current_weather[:sunset]).to be_a String
        expect(DateTime.parse(current_weather[:sunset])).to be_a DateTime
        expect(current_weather).to have_key(:temperature)
        expect(current_weather[:temperature]).to be_a Float
        expect(current_weather).to have_key(:feels_like)
        expect(current_weather[:feels_like]).to be_a Float
        expect(current_weather).to have_key(:humidity)
        expect(current_weather[:humidity]).to be_a Numeric
        expect(current_weather).to have_key(:uvi)
        expect(current_weather[:uvi]).to be_a Numeric
        expect(current_weather).to have_key(:visibility)
        expect(current_weather[:visibility]).to be_a Numeric
        expect(current_weather).to have_key(:conditions)
        expect(current_weather[:conditions]).to be_a String
        expect(current_weather).to have_key(:icon)
        expect(current_weather[:icon]).to be_a String

        expect(current_weather).to_not have_key(:dew_point)
        expect(current_weather).to_not have_key(:wind_speed)
        expect(current_weather).to_not have_key(:wind_deg)
        expect(current_weather).to_not have_key(:wind_gust)
        expect(current_weather).to_not have_key(:clouds)
        expect(current_weather).to_not have_key(:pop)
        expect(current_weather).to_not have_key(:rain)


        daily_weather = forecast.daily_weather
        expect(daily_weather.count).to eq(5)

        day = daily_weather.first
        expect(day).to be_a Hash
        expect(day.keys.count).to eq (7)

        expect(day).to have_key(:date)
        expect(day[:date]).to be_a Date
        expect(day).to have_key(:sunrise)
        expect(day[:sunrise]).to be_a String
        expect(DateTime.parse(day[:sunrise])).to be_a DateTime
        expect(day).to have_key(:sunset)
        expect(day[:sunset]).to be_a String
        expect(DateTime.parse(day[:sunset])).to be_a DateTime
        expect(day).to have_key(:max_temp)
        expect(day[:max_temp]).to be_a Float
        expect(day).to have_key(:min_temp)
        expect(day[:min_temp]).to be_a Float
        expect(day).to have_key(:conditions)
        expect(day[:conditions]).to be_a String
        expect(day).to have_key(:icon)
        expect(day[:icon]).to be_a String

        expect(day).to_not have_key(:moonrise)
        expect(day).to_not have_key(:moonset)
        expect(day).to_not have_key(:feels_like)
        expect(day).to_not have_key(:pressure)
        expect(day).to_not have_key(:humidity)
        expect(day).to_not have_key(:dew_point)
        expect(day).to_not have_key(:visibility)
        expect(day).to_not have_key(:wind_speed)
        expect(day).to_not have_key(:wind_deg)
        expect(day).to_not have_key(:wind_gust)
        expect(day).to_not have_key(:clouds)
        expect(day).to_not have_key(:pop)
        expect(day).to_not have_key(:rain)
        expect(day).to_not have_key(:uvi)

        hourly_weather = forecast.hourly_weather
        expect(hourly_weather.count).to eq(8)

        hour = hourly_weather.first
        expect(hour).to be_a Hash
        expect(hour.keys.count).to eq (4)

        expect(hour).to have_key(:time)
        expect(hour[:time]).to be_a String
        expect(Time.parse(hour[:time])).to be_a Time
        expect(hour).to have_key(:temperature)
        expect(hour[:temperature]).to be_a Float
        expect(hour[:conditions]).to be_a String
        expect(hour).to have_key(:icon)
        expect(hour[:icon]).to be_a String

        expect(hour).to_not have_key(:feels_like)
        expect(hour).to_not have_key(:pressure)
        expect(hour).to_not have_key(:humidity)
        expect(hour).to_not have_key(:dew_point)
        expect(hour).to_not have_key(:uvi)
        expect(hour).to_not have_key(:clouds)
        expect(hour).to_not have_key(:visibility)
        expect(hour).to_not have_key(:wind_speed)
        expect(hour).to_not have_key(:wind_deg)
        expect(hour).to_not have_key(:wind_gust)
        expect(hour).to_not have_key(:pop)
      end
    end
  end
end
