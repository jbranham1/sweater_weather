require "rails_helper"

RSpec.describe DailyWeather do
  before :each do
    @attrs = {
      :dt=>1619373600,
      :sunrise=>1619352457,
      :sunset=>1619401664,
      :temp=>{:day=>69.4, :min=>47.25, :max=>77.34, :night=>63.09, :eve=>76.8, :morn=>47.25},
      :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03d"}],
    }
   @daily_weather = DailyWeather.new(@attrs)
 end
 it "exists" do
    expect(@daily_weather).to be_a DailyWeather
    expect(@daily_weather.date).to be_a Date
    expect(@daily_weather.date).to eq(Time.at(@attrs[:dt]).to_date)
    expect(@daily_weather.sunrise).to be_a String
    expect(DateTime.parse(@daily_weather.sunrise)).to be_a DateTime
    expect(@daily_weather.sunrise).to eq(Time.at(@attrs[:sunrise]).strftime("%F %T %z"))
    expect(@daily_weather.sunset).to be_a String
    expect(DateTime.parse(@daily_weather.sunset)).to be_a DateTime
    expect(@daily_weather.sunset).to eq(Time.at(@attrs[:sunset]).strftime("%F %T %z"))
    expect(@daily_weather.max_temp).to be_a Float
    expect(@daily_weather.max_temp).to eq(@attrs[:temp][:max])
    expect(@daily_weather.min_temp).to be_a Float
    expect(@daily_weather.min_temp).to eq(@attrs[:temp][:min])
    expect(@daily_weather.conditions).to be_a String
    expect(@daily_weather.conditions).to eq(@attrs[:weather].first[:description])
    expect(@daily_weather.icon).to be_a String
    expect(@daily_weather.icon).to eq(@attrs[:weather].first[:icon])
  end
end
