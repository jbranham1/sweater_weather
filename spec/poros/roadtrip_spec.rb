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
        formattedTime: "01:44:22",
        locations: [{
          adminArea5: "Denver",
          postalCode: "",
          adminArea1: "US",
          adminArea3: "CO",
          street: "",
        },
        {
          adminArea5: "Pueblo",
          postalCode: "",
          adminArea1: "US",
          adminArea3: "CO",
          street: "",
        }]
      }
    }
  end
  it "exists" do
    VCR.use_cassette("weather_for_roadtrip") do
      trip = Roadtrip.new(@attrs)
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
  describe "get_address" do
    it "formats addresses correctly" do
      VCR.use_cassette("weather_for_roadtrip") do
        trip = Roadtrip.new(@attrs)
        location = @attrs[:route][:locations].first
        expect(trip.get_address(location)).to eq("Denver, CO")
      end
    end
  end
  describe "get_weather" do
    it "gets the weather for the arrival time" do
      VCR.use_cassette("weather_for_roadtrip_small") do
        trip = Roadtrip.new(@attrs)
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
            formattedTime: "40:44:22",
            locations: [{
              adminArea5: "Denver",
              postalCode: "",
              adminArea1: "US",
              adminArea3: "CO",
              street: "",
            },
            {
              adminArea5: "Key West",
              postalCode: "",
              adminArea1: "US",
              adminArea3: "CO",
              street: "",
            }]
          }
        }
        trip = Roadtrip.new(attrs2)
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
        trip = Roadtrip.new(@attrs)
        date = @attrs[:route][:formattedTime]
        expect(trip.alter_date(date)).to eq("Mon, 26 Apr 2021 10:00:00 -0500")
      end
    end
    it "gets date  for arrival" do
      VCR.use_cassette("weather_for_roadtrip") do
        trip = Roadtrip.new(@attrs)
        date = @attrs[:route][:formattedTime]
        expect(trip.alter_date(date,false)).to eq("Mon, 26 Apr 2021 12:00:00 -0500")
      end
    end
  end
end
