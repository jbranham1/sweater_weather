require 'rails_helper'

RSpec.describe 'Forecast Search'do
  describe 'happy path' do
    it 'can return the forecast from a city and state search' do
      get '/api/v1/forecast?location=denver,co'
      expect(response).to be_successful
      forecast = JSON.parse(response.body, symbolize_names:true)
      expect(forecast).to be_a(Hash)
      expect(forecast[:data]).to be_a(Hash)
      expect(forecast[:data].count).to eq(3)
      expect(forecast[:data][:id]).to_be nil
      expect(forecast[:data][:type]).to eq("forecast")
      expect(forecast[:data][:attributes].count).to eq(3)

      expect(forecast[:data][:attributes]).to have_key(:current_weather)
      current_weather = forecast[:data][:attributes][:current_weather]
      expect(current_weather.count).to eq(10)
      expect(current_weather).to have_key(:datetime)
      expect(current_weather[:datetime]).to be_a DateTime
      expect(current_weather).to have_key(:sunrise)
      expect(current_weather[:sunrise]).to be_a DateTime
      expect(current_weather).to have_key(:sunset)
      expect(current_weather[:sunset]).to be_a DateTime
      expect(current_weather).to have_key(:temperature)
      expect(current_weather[:temperature]).to be_a Float
      expect(current_weather).to have_key(:feels_like)
      expect(current_weather[:feels_like]).to be_a Float
      expect(current_weather).to have_key(:humidity)
      expect(current_weather[:humidity]).to be_a Float
      expect(current_weather).to have_key(:uvi)
      expect(current_weather[:uvi]).to be_a Float
      expect(current_weather).to have_key(:conditions)
      expect(current_weather[:conditions]).to be_a String
      expect(current_weather).to have_key(:icon)
      expect(current_weather[:icon]).to be_a String


      expect(forecast[:data][:attributes]).to have_key(:daily_weather)
      daily_weather = forecast[:data][:attributes][:daily_weather]
      expect(daily_weather.count).to eq(7)
      expect(daily_weather).to have_key(:date)
      expect(daily_weather[:date]).to be_a DateTime
      expect(daily_weather).to have_key(:sunrise)
      expect(daily_weather[:sunrise]).to be_a DateTime
      expect(daily_weather).to have_key(:sunset)
      expect(daily_weather[:sunset]).to be_a DateTime
      expect(daily_weather).to have_key(:max_temp)
      expect(daily_weather[:max_temp]).to be_a Float
      expect(daily_weather).to have_key(:min_temp)
      expect(daily_weather[:min_temp]).to be_a Float
      expect(daily_weather).to have_key(:conditions)
      expect(daily_weather[:conditions]).to be_a String
      expect(daily_weather).to have_key(:icon)
      expect(daily_weather[:icon]).to be_a String

      expect(forecast[:data][:attributes]).to have_key(:hourly_weather)
      hourly_weather = forecast[:data][:attributes][:hourly_weather]
      expect(hourly_weather.count).to eq(4)
      expect(hourly_weather).to have_key(:time)
      expect(hourly_weather[:time]).to be_a Time
      expect(hourly_weather).to have_key(:temperature)
      expect(hourly_weather[:temperature]).to be_a Float
      expect(daily_weather[:conditions]).to be_a String
      expect(daily_weather).to have_key(:icon)
      expect(daily_weather[:icon]).to be_a String
    end
  end
end
