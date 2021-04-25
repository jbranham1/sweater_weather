require 'rails_helper'

RSpec.describe "Mapquest Search" do
  describe "find coordinal location" do
    it "returns the latitude and longitude of a city" do
      VCR.use_cassette("mapquest_service") do
        location = "denver, co"
        response = MapquestService.find_coordinal_location(location)

        expect(response).to be_a Hash
        expect(response).to have_key(:info)
        expect(response).to have_key(:results)
        results = response[:results]

        expect(results).to be_an Array
        results1 = results.first
        expect(results1).to be_a Hash
        expect(results1).to have_key(:locations)
        expect(results1[:locations]).to be_an Array
        location = results1[:locations].first

        expect(location).to have_key(:latLng)
        expect(location[:latLng]).to be_a Hash
        expect(location[:latLng]).to have_key(:lat)
        expect(location[:latLng]).to have_key(:lng)
      end
    end
    describe "sad path" do
      it "returns a 400 error if location is empty" do
        VCR.use_cassette("mapquest_service_empty_location") do
          location = ""
          response = MapquestService.find_coordinal_location(location)

          expect(response).to be_a Hash
          expect(response).to have_key(:info)

          expect(response[:info]).to have_key(:statuscode)
          expect(response[:info][:statuscode]).to eq(400)
          expect(response[:info]).to have_key(:messages)
          expect(response[:info][:messages]).to eq(["Illegal argument from request: Insufficient info for location"])
        end
      end
    end
  end
  describe "find route" do
    it "returns the route of a trip when given origin and destination locations" do
      VCR.use_cassette("mapquest_route_service") do
        origin = "conway,ar"
        destination = "denver,co"
        response = MapquestService.find_directions(origin, destination)

        expect(response).to be_a Hash
        expect(response).to have_key(:route)
        route = response[:route]

        expect(route).to be_a Hash
        expect(route).to have_key(:hasTollRoad)
        expect(route).to have_key(:boundingBox)
        expect(route[:boundingBox]).to be_a Hash
        expect(route).to have_key(:distance)
        expect(route[:distance]).to be_a Float
        expect(route).to have_key(:hasTimedRestriction)
        expect(route).to have_key(:hasTunnel)
        expect(route).to have_key(:hasHighway)
        expect(route).to have_key(:formattedTime)
        expect(route[:formattedTime]).to be_a String
        expect(route).to have_key(:realTime)
        expect(route[:realTime]).to be_a Integer
      end
    end
    describe "sad path" do
      it "returns an error if origin is empty" do
        VCR.use_cassette("mapquest_route_service_empty_origin") do
          origin = ""
          destination = "denver,co"
          response = MapquestService.find_directions(origin, destination)

          expect(response).to be_a Hash
          expect(response).to have_key(:info)

          expect(response[:info]).to have_key(:statuscode)
          expect(response[:info][:statuscode]).to eq(611)
          expect(response[:info]).to have_key(:messages)
          expect(response[:info][:messages]).to eq(["At least two locations must be provided."])
        end
      end
      it "returns an error if destination is empty" do
        VCR.use_cassette("mapquest_route_service_empty_destination") do
          origin = ""
          destination = ""
          response = MapquestService.find_directions(origin, destination)

          expect(response).to be_a Hash
          expect(response).to have_key(:info)

          expect(response[:info]).to have_key(:statuscode)
          expect(response[:info][:statuscode]).to eq(611)
          expect(response[:info]).to have_key(:messages)
          expect(response[:info][:messages]).to eq(["At least two locations must be provided."])
        end
      end
      it "returns an error if destination is overseas" do
        VCR.use_cassette("mapquest_route_service_impossible destination") do
          origin = "conway,ar"
          destination = "london,uk"
          response = MapquestService.find_directions(origin, destination)

          expect(response).to be_a Hash
          expect(response).to have_key(:info)

          expect(response[:info]).to have_key(:statuscode)
          expect(response[:info][:statuscode]).to eq(402)
          expect(response[:info]).to have_key(:messages)
          expect(response[:info][:messages]).to eq(["We are unable to route with the given locations."])
        end
      end
    end
  end
end
