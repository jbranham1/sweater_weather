require 'rails_helper'

RSpec.describe 'Roadtrip Facade'do
  describe 'get_route' do
    it 'can return the route for a origin and destination' do
      VCR.use_cassette "roadtrip" do
        origin = "Denver,CO"
        destination = "Pueblo,CO"

        trip = RoadTripFacade.get_route(origin, destination)

        expect(trip).to be_a(Roadtrip)
        expect(trip.start_city).to be_a String
        expect(trip.end_city).to be_a String
        expect(trip.travel_time).to be_a String
        expect(trip.weather_at_eta).to be_a Hash

        expect(trip.weather_at_eta).to have_key(:temperature)
        expect(trip.weather_at_eta[:temperature]).to be_a Float
        expect(trip.weather_at_eta).to have_key(:conditions)
        expect(trip.weather_at_eta[:conditions]).to be_a String
      end
    end
    it 'can return the impossible route for a origin and destination' do
      VCR.use_cassette "roadtrip_overseas" do
        origin = "Denver,CO"
        destination = "London,UK"

        trip = RoadTripFacade.get_route(origin, destination)

        expect(trip).to be_a(Roadtrip)
        expect(trip.start_city).to be_a String
        expect(trip.end_city).to be_a String
        expect(trip.travel_time).to be_a String
        expect(trip.travel_time).to eq("impossible route")
        expect(trip.weather_at_eta).to be_a Hash
        expect(trip.weather_at_eta.empty?).to be true
      end
    end
    it 'can return the long route for a origin and destination' do
      VCR.use_cassette "roadtrip-long" do
        origin = "Seattle, WA"
        destination = "Key West, FL"

        trip = RoadTripFacade.get_route(origin, destination)

        expect(trip).to be_a(Roadtrip)
        expect(trip.start_city).to be_a String
        expect(trip.end_city).to be_a String
        expect(trip.travel_time).to be_a String
        expect(trip.weather_at_eta).to be_a Hash

        expect(trip.weather_at_eta).to have_key(:temperature)
        expect(trip.weather_at_eta[:temperature]).to be_a Float
        expect(trip.weather_at_eta).to have_key(:conditions)
        expect(trip.weather_at_eta[:conditions]).to be_a String
      end
    end
  end
end
