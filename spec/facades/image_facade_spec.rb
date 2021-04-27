require 'rails_helper'

RSpec.describe 'Image Facade'do
  describe 'get_image' do
    it 'can return the image from a city and state search' do
      VCR.use_cassette "background" do
        location = "denver,co downtown"
        image = ImageFacade.get_image(location)

        expect(image).to be_a(Image)
        expect(image.location).to eq(location.titleize)
        expect(image.image_url).to be_a String
        expect(image.description).to be_a String
        expect(image.credit).to be_a Hash

        expect(image.credit).to have_key(:source)
        expect(image.credit[:source]).to be_a String
        expect(image.credit).to have_key(:author)
        expect(image.credit[:author]).to be_a String
        expect(image.credit).to have_key(:author_profile)
        expect(image.credit[:author_profile]).to be_a String
      end
    end
    it "cant' return an image if there is no location" do
      VCR.use_cassette "background_no_location" do
        location = ""
        image = ImageFacade.get_image(location)

        expect(image).to be_a(Hash)
        expect(image.empty?).to be true
      end
    end
  end
end
