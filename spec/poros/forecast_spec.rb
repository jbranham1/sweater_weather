require "rails_helper"

RSpec.describe Forecast do
  before :each do
    @attrs = {
      :lat=>39.7385,
      :lon=>-104.9849,
      :timezone=>"America/Denver",
      :timezone_offset=>-21600,
      :current=>{
        :dt=>1619390990,
        :sunrise=>1619352457,
        :sunset=>1619401664,
        :temp=>77.34,
        :feels_like=>75.15,
        :pressure=>998,
        :humidity=>8,
        :uvi=>2.18,
        :clouds=>25,
        :visibility=>10000,
        :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03d"}]
      },
      :hourly=>[
        {
          :dt=>1619388000,
          :temp=>77.05,
          :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03d"}],
        },
        {
          :dt=>1619391600,
          :temp=>77.34,
          :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03d"}],
        }
      ],
      daily: [
        {
          :dt=>1619373600,
          :sunrise=>1619352457,
          :sunset=>1619401664,
          :temp=>{:day=>69.4, :min=>47.25, :max=>77.34, :night=>63.09, :eve=>76.8, :morn=>47.25},
          :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03d"}],
        },
        {
          :dt=>1619460000,
          :sunrise=>1619438778,
          :sunset=>1619488125,
          :temp=>{:day=>71.87, :min=>52.65, :max=>77.38, :night=>60.82, :eve=>73.83, :morn=>52.65},
          :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03d"}],
        }
      ]
    }

    @forecast = Forecast.new(@attrs)
  end
  it "exists" do
    expect(@forecast).to be_a Forecast
    expect(@forecast.id).to eq(nil)
    expect(@forecast.current_weather).to be_a CurrentWeather
    expect(@forecast.daily_weather.first).to be_an DailyWeather
    expect(@forecast.hourly_weather.first).to be_an HourlyWeather
  end
  describe 'get_current_weather' do
    it 'can return the current weather from a city and state search' do
      current_weather = @forecast.current_weather

      expect(current_weather).to be_a CurrentWeather
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
    end
  end

  describe 'get_daily_weather' do
    it 'can return the daily weather from a city and state search' do
      daily_weather = @forecast.get_daily_weather(@attrs[:daily]).first

      expect(daily_weather).to be_a DailyWeather
      expect(daily_weather.date).to be_a Date
      expect(daily_weather.sunrise).to be_a String
      expect(DateTime.parse(daily_weather.sunrise)).to be_a DateTime
      expect(daily_weather.sunset).to be_a String
      expect(DateTime.parse(daily_weather.sunset)).to be_a DateTime
      expect(daily_weather.max_temp).to be_a Float
      expect(daily_weather.min_temp).to be_a Float
      expect(daily_weather.conditions).to be_a String
      expect(daily_weather.icon).to be_a String
    end
  end
  describe 'get_hourly_weather' do
    it 'can return the hourly weather from a city and state search' do
      hourly_weather = @forecast.get_hourly_weather(@attrs[:hourly]).first
      expect(hourly_weather).to be_a HourlyWeather
      expect(DateTime.parse(hourly_weather.time)).to be_a DateTime
      expect(hourly_weather.temperature).to be_a Float
      expect(hourly_weather.conditions).to be_a String
      expect(hourly_weather.icon).to be_a String
    end
  end
end
