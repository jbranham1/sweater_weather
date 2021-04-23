require 'rails_helper'

RSpec.describe "Mapquest Search" do
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
