require 'rails_helper'

RSpec.describe "Weather Search" do
  it "returns the current weather from OpenWeather One Call API when given coordinal location" do
    VCR.use_cassette("current_weather") do
      location = {lat: 39.738453, lng: -104.984853}
      response = WeatherService.find_weather(location)

      expect(response).to be_a Hash
      expect(response).to have_key(:lat)
      expect(response).to have_key(:lon)
      expect(response).to have_key(:timezone)
      expect(response).to have_key(:timezone_offset)
      expect(response).to have_key(:current)
      expect(response).to have_key(:daily)
      expect(response.keys.count).to eq(8)
      current = response[:current]

      expect(current).to be_a Hash
      expect(current).to have_key(:dt)
      expect(current[:dt]).to be_a Integer
      expect(current).to have_key(:sunrise)
      expect(current[:sunrise]).to be_a Integer
      expect(current).to have_key(:sunset)
      expect(current[:sunset]).to be_a Integer
      expect(current).to have_key(:temp)
      expect(current[:temp]).to be_a Float
      expect(current).to have_key(:feels_like)
      expect(current[:feels_like]).to be_a Float
      expect(current).to have_key(:pressure)
      expect(current[:pressure]).to be_a Integer
      expect(current).to have_key(:humidity)
      expect(current[:humidity]).to be_a Integer
      expect(current).to have_key(:uvi)
      expect(current[:uvi]).to be_a Float
      expect(current).to have_key(:visibility)
      expect(current[:visibility]).to be_a Numeric
      expect(current).to have_key(:weather)
      expect(current[:weather]).to be_an Array
      expect(current[:weather].first).to be_a Hash
      expect(current[:weather].first).to have_key(:main)
      expect(current[:weather].first[:main]).to be_a String
      expect(current[:weather].first).to have_key(:description)
      expect(current[:weather].first[:description]).to be_a String
      expect(current[:weather].first).to have_key(:icon)
      expect(current[:weather].first[:icon]).to be_a String

      daily = response[:daily]
      expect(daily).to be_an Array
      day_1 = response[:daily].first

      expect(day_1).to be_a Hash
      expect(day_1).to have_key(:dt)
      expect(day_1[:dt]).to be_a Integer
      expect(day_1).to have_key(:sunrise)
      expect(day_1[:sunrise]).to be_a Integer
      expect(day_1).to have_key(:sunset)
      expect(day_1[:sunset]).to be_a Integer
      expect(day_1).to have_key(:moonrise)
      expect(day_1[:moonrise]).to be_a Integer
      expect(day_1).to have_key(:moonset)
      expect(day_1[:moonset]).to be_a Integer
      expect(day_1).to have_key(:pressure)
      expect(day_1[:pressure]).to be_a Numeric
      expect(day_1).to have_key(:humidity)
      expect(day_1[:humidity]).to be_a Numeric
      expect(day_1).to have_key(:uvi)
      expect(day_1[:uvi]).to be_a Numeric
      expect(day_1).to have_key(:temp)
      expect(day_1[:temp]).to be_a Hash
      expect(day_1[:temp]).to have_key(:min)
      expect(day_1[:temp][:min]).to be_a Numeric
      expect(day_1[:temp]).to have_key(:max)
      expect(day_1[:temp][:max]).to be_a Numeric
      expect(day_1).to have_key(:weather)
      expect(day_1[:weather]).to be_an Array
      expect(day_1[:weather].first).to be_a Hash
      expect(day_1[:weather].first).to have_key(:main)
      expect(day_1[:weather].first[:main]).to be_a String
      expect(day_1[:weather].first).to have_key(:description)
      expect(day_1[:weather].first[:description]).to be_a String
      expect(day_1[:weather].first).to have_key(:icon)
      expect(day_1[:weather].first[:icon]).to be_a String


      hourly = response[:hourly]
      expect(hourly).to be_an Array
      hour_1 = response[:hourly].first

      expect(hour_1).to be_a Hash
      expect(hour_1).to have_key(:dt)
      expect(hour_1[:dt]).to be_a Integer
      expect(hour_1).to have_key(:temp)
      expect(hour_1[:temp]).to be_a Float
      expect(hour_1).to have_key(:feels_like)
      expect(hour_1[:feels_like]).to be_a Float
      expect(hour_1).to have_key(:pressure)
      expect(hour_1[:pressure]).to be_a Integer
      expect(hour_1).to have_key(:humidity)
      expect(hour_1[:humidity]).to be_a Integer
      expect(hour_1).to have_key(:uvi)
      expect(hour_1[:uvi]).to be_a Float
      expect(hour_1).to have_key(:visibility)
      expect(hour_1[:visibility]).to be_a Numeric
      expect(hour_1).to have_key(:weather)
      expect(hour_1[:weather]).to be_an Array
      expect(hour_1[:weather].first).to be_a Hash
      expect(hour_1[:weather].first).to have_key(:main)
      expect(hour_1[:weather].first[:main]).to be_a String
      expect(hour_1[:weather].first).to have_key(:description)
      expect(hour_1[:weather].first[:description]).to be_a String
      expect(hour_1[:weather].first).to have_key(:icon)
      expect(hour_1[:weather].first[:icon]).to be_a String
    end
  end
  describe "sad path" do
    it "returns a 400 error if latitiude is not present" do
      VCR.use_cassette("current_weather_no_latitude") do
        location = {lng: -104.984853}
        response = WeatherService.find_weather(location)
        expect(response).to have_key(:cod)
        expect(response[:cod]).to eq("400")
        expect(response).to have_key(:message)
        expect(response[:message]).to eq("Nothing to geocode")
      end
    end
    it "returns a 400 error if longitude is not present" do
      VCR.use_cassette("current_weather_no_longitude") do
        location = {lat: -104.984853}
        response = WeatherService.find_weather(location)
        expect(response).to have_key(:cod)
        expect(response[:cod]).to eq("400")
        expect(response).to have_key(:message)
        expect(response[:message]).to eq("Nothing to geocode")
      end
    end
  end
end
