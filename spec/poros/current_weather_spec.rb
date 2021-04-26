require "rails_helper"

RSpec.describe CurrentWeather do
  before :each do
    @attrs = {
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
    }
   @current_weather = CurrentWeather.new(@attrs)
 end
 it "exists" do
    expect(@current_weather).to be_a CurrentWeather
    expect(DateTime.parse(@current_weather.datetime)).to be_a DateTime
    expect(@current_weather.datetime).to eq(Time.at(@attrs[:dt]).strftime("%F %T %z"))
    expect(@current_weather.sunrise).to be_a String
    expect(DateTime.parse(@current_weather.sunrise)).to be_a DateTime
    expect(@current_weather.sunrise).to eq(Time.at(@attrs[:sunrise]).strftime("%F %T %z"))
    expect(@current_weather.sunset).to be_a String
    expect(DateTime.parse(@current_weather.sunset)).to be_a DateTime
    expect(@current_weather.sunset).to eq(Time.at(@attrs[:sunset]).strftime("%F %T %z"))
    expect(@current_weather.temperature).to be_a Float
    expect(@current_weather.temperature).to eq (@attrs[:temp])
    expect(@current_weather.feels_like).to be_a Float
    expect(@current_weather.feels_like).to eq (@attrs[:feels_like])
    expect(@current_weather.humidity).to be_a Numeric
    expect(@current_weather.humidity).to eq (@attrs[:humidity])
    expect(@current_weather.uvi).to be_a Numeric
    expect(@current_weather.uvi).to eq (@attrs[:uvi])
    expect(@current_weather.visibility).to be_a Numeric
    expect(@current_weather.visibility).to eq (@attrs[:visibility])
    expect(@current_weather.conditions).to be_a String
    expect(@current_weather.icon).to eq (@attrs[:weather].first[:icon])
    expect(@current_weather.icon).to be_a String
    expect(@current_weather.icon).to eq (@attrs[:weather].first[:icon])
  end
end
