require 'rails_helper'

RSpec.describe "Mapquest Search" do
  it "returns the latitude and longitude of a city" do
    VCR.use_cassette("mapquest_service") do
      city = "denver, co"
      response = MapquestService.find_coordinal_location(city)

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
end
