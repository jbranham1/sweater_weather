require 'rails_helper'

RSpec.describe "Unsplash Search" do
  it "returns an image based on a location search" do
    VCR.use_cassette("unsplash_service") do
      location = "denver, co"
      response = UnsplashService.find_image(location)

      expect(response).to be_a Hash
      expect(response).to have_key(:total)
      expect(response).to have_key(:total_pages)
      expect(response).to have_key(:results)
      results = response[:results]

      expect(results).to be_an Array
      results1 = results.first
      expect(results1).to be_a Hash
      expect(results1).to have_key(:id)
      expect(results1[:id]).to be_a String
      expect(results1).to have_key(:created_at)
      expect(results1[:created_at]).to be_a String
      expect(results1).to have_key(:updated_at)
      expect(results1[:updated_at]).to be_a String
      expect(results1).to have_key(:width)
      expect(results1[:width]).to be_a Integer
      expect(results1).to have_key(:height)
      expect(results1[:height]).to be_a Integer
      expect(results1).to have_key(:color)
      expect(results1[:color]).to be_a String
      expect(results1).to have_key(:blur_hash)
      expect(results1[:blur_hash]).to be_a String
      expect(results1).to have_key(:description)
      expect(results1[:description]).to be_a String
      expect(results1).to have_key(:alt_description)
      expect(results1[:alt_description]).to be_a String
      expect(results1).to have_key(:urls)
      expect(results1[:urls]).to be_a Hash
      expect(results1[:urls]).to have_key(:regular)
      expect(results1[:urls][:regular]).to be_a String

      expect(results1).to have_key(:user)
      expect(results1[:user]).to be_a Hash

      expect(results1[:user]).to have_key(:username)
      expect(results1[:user][:username]).to be_a String
      expect(results1[:user]).to have_key(:links)
      expect(results1[:user][:links]).to be_a Hash

      expect(results1[:user][:links]).to have_key(:self)
      expect(results1[:user][:links][:html]).to be_a String
    end
  end
  describe "sad path" do
    it "returns an empty has if location is empty" do
      VCR.use_cassette("unsplash_service_empty_location") do
        location = ""
        response = UnsplashService.find_image(location)

        expect(response).to be_a Hash
        expect(response).to have_key(:total)
        expect(response[:total]).to eq(0)
        expect(response).to have_key(:total_pages)
        expect(response[:total_pages]).to eq(0)
        expect(response).to have_key(:results)
        expect(response[:results]).to eq([])
      end
    end
  end
end
