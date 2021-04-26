require "rails_helper"

RSpec.describe Roadtrip do
  before :each do
    @attrs = {
      route: {
        boundingBox: {
          lr: {
            lng: -104.605087,
            lat: 38.265427},
          ul: {
            lng: -104.98761,
            lat: 39.738453}
          },
        formattedTime: "01:44:22"
      },
      info: {
        messages: []
      }
    }
  end
  it "exists" do
    VCR.use_cassette("weather_for_roadtrip") do
      trip = Roadtrip.new(@attrs, "Denver,CO", "Pueblo,CO")
      expect(trip).to be_a Roadtrip
      expect(trip.id).to eq(nil)
      expect(trip.start_city).to be_a String
      expect(trip.end_city).to be_a String
      expect(trip.travel_time).to be_a String
      expect(trip.travel_time).to eq(@attrs[:route][:formattedTime])
      expect(trip.weather_at_eta).to be_a Hash
      expect(trip.weather_at_eta[:temperature]).to be_a Float
      expect(trip.weather_at_eta[:conditions]).to be_a String
    end
  end
  describe "get_weather" do
    it "gets the weather for the arrival time" do
      VCR.use_cassette("weather_for_roadtrip_small") do
        trip = Roadtrip.new(@attrs, "Denver,CO", "Pueblo,CO")
        weather = trip.get_weather(@attrs)
        expect(weather).to be_a Hash
        expect(weather).to have_key(:temperature)
        expect(weather[:temperature]).to be_a Float
        expect(weather).to have_key(:conditions)
        expect(weather[:conditions]).to be_a String
      end
    end
    it "gets the weather for the arrival time" do
      VCR.use_cassette("weather_for_roadtrip_large") do
        attrs2 = {
          route: {
            boundingBox: {
              lr: {
                lng: -104.605087,
                lat: 38.265427},
              ul: {
                lng: -104.98761,
                lat: 39.738453}
              },
            formattedTime: "49:44:22"
          },
          info: {
            messages: []
          }
        }
        trip = Roadtrip.new(@attrs, "Seattle,WA", "Key West,FL")
        weather = trip.get_weather(attrs2)
        expect(weather).to be_a Hash
        expect(weather).to have_key(:temperature)
        expect(weather[:temperature]).to be_a Float
        expect(weather).to have_key(:conditions)
        expect(weather[:conditions]).to be_a String
      end
    end
  end
  describe "alter_date" do
    it "gets date and time for arrival" do
      VCR.use_cassette("weather_for_roadtrip") do
        trip = Roadtrip.new(@attrs, "Denver,CO", "Pueblo,CO")
        date = @attrs[:route][:formattedTime]
        expect(trip.alter_date(date)).to be_a DateTime
      end
    end
    it "gets date for arrival" do
      VCR.use_cassette("weather_for_roadtrip") do
        trip = Roadtrip.new(@attrs, "Denver,CO", "Pueblo,CO")
        date = @attrs[:route][:formattedTime]
        expect(trip.alter_date(date,false)).to be_a DateTime
      end
    end
    it "returns impossible if route is overseas" do
      VCR.use_cassette("weather_for_roadtrip_overseas") do
        attrs2 = {
          route: {
            boundingBox: {
              lr: {
                lng: -104.605087,
                lat: 38.265427},
              ul: {
                lng: -104.98761,
                lat: 39.738453}
              },
            formattedTime: "49:44:22"
          },
          info: {
            messages: ["Trip is overseas"]
          }
        }
        trip = Roadtrip.new(attrs2, "Seattle,WA", "London,UK")
        expect(trip.travel_time).to eq("impossible route")
        expect(trip.weather_at_eta).to be_a Hash
        expect(trip.weather_at_eta.empty?).to eq(true)
      end
    end
  end
end
