require 'rails_helper'

RSpec.describe 'Background Search'do
  describe 'happy path' do
    it 'can return an image for a location' do
      VCR.use_cassette "background" do
        location = 'denver,co downtown'
        get "/api/v1/background?location=#{location}"
        expect(response).to be_successful
        expect(response.status).to eq(200)
        background = JSON.parse(response.body, symbolize_names:true)

        expect(background).to be_a(Hash)
        expect(background[:data]).to be_a(Hash)
        expect(background[:data].count).to eq(3)
        expect(background[:data][:id].nil?).to eq true
        expect(background[:data][:type]).to eq("image")
        expect(background[:data][:attributes].count).to eq(4)

        image = background[:data][:attributes]

        expect(image).to have_key(:location)
        expect(image[:location]).to be_a String
        expect(image).to have_key(:image_url)
        expect(image[:image_url]).to be_a String
        expect(image).to have_key(:description)
        expect(image[:description]).to be_a String
        expect(image).to have_key(:credit)
        expect(image[:credit]).to be_a Hash

        credit = image[:credit]
        expect(credit).to have_key(:source)
        expect(credit[:source]).to be_a String
        expect(credit).to have_key(:author)
        expect(credit[:author]).to be_a String
        expect(credit).to have_key(:author_profile)
        expect(credit[:author_profile]).to be_a String


        expect(image).to_not have_key(:created_at)
        expect(image).to_not have_key(:updated_at)
        expect(image).to_not have_key(:width)
        expect(image).to_not have_key(:height)
        expect(image).to_not have_key(:color)
        expect(image).to_not have_key(:alt_description)
      end
    end
  end
end
