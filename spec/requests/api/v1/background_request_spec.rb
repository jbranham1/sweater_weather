require 'rails_helper'

RSpec.describe 'Background Search'do
  describe 'happy path' do
    it 'can return an image for a location' do
      VCR.use_cassette "background" do
        get '/api/v1/background?location=denver,co'
        expect(response).to be_successful
        expect(response.status).to eq(200)
        background = JSON.parse(response.body, symbolize_names:true)

        expect(background).to be_a(Hash)
        expect(background[:data]).to be_a(Hash)
        expect(background[:data].count).to eq(3)
        expect(background[:data][:id].nil?).to eq true
        expect(background[:data][:type]).to eq("image")
        expect(background[:data][:attributes].count).to eq(1)

        expect(background[:data][:attributes]).to have_key(:image)
        image = background[:data][:attributes][:image]
        expect(image.count).to eq(3)
        expect(image).to have_key(:location)
        expect(image[:location]).to be_a String
        expect(image).to have_key(:image_url)
        expect(image[:image_url]).to be_a String
        expect(image).to have_key(:credit)
        expect(image[:credit]).to be_a String

        credit = image[:credit]
        expect(credit).to have_key(:source)
        expect(credit[:source]).to be_a String
        expect(credit).to have_key(:author)
        expect(credit[:author]).to be_a String
        expect(credit).to have_key(:logo)
        expect(credit[:logo]).to be_a String


        expect(image).to_not have_key(:dew_point)
        expect(image).to_not have_key(:wind_speed)
        expect(image).to_not have_key(:wind_deg)
        expect(image).to_not have_key(:wind_gust)
        expect(image).to_not have_key(:clouds)
        expect(image).to_not have_key(:pop)
        expect(image).to_not have_key(:rain)
      end
    end
  end
end
