require "rails_helper"

RSpec.describe HourlyWeather do
  before :each do
    @attrs = {
      :dt=>1619388000,
      :temp=>77.05,
      :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03d"}],
    }
   @hourly_weather = HourlyWeather.new(@attrs)
 end
 it "exists" do
    expect(@hourly_weather).to be_a HourlyWeather
    expect(DateTime.parse(@hourly_weather.time)).to be_a DateTime
    expect(@hourly_weather.temperature).to be_a Float
    expect(@hourly_weather.conditions).to be_a String
    expect(@hourly_weather.icon).to be_a String
  end
end
