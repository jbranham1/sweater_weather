require "rails_helper"

RSpec.describe Image do
  before :each do
    @location = "denver,co downtown"
    @attrs = {
      results: [{
        description: "Downtown Denver summer 2017",
        urls: {
          regular: "https://images.unsplash.com/photo-1603033156166-2ae22eb2b7e2?crop=entropy&cs=tinysrgb&fit=max"
        },
        links: {
          html: "https://unsplash.com/photos/m49y6IOk784"
        },
        user: {
          name: "Andrew Coop",
          links:  {
            html: "https://unsplash.com/@andrewcoop"
          }
        }
      }]
    }
    @image = Image.new(@attrs, @location)
  end
  it "exists" do
    expect(@image).to be_a Image
    expect(@image.id).to eq(nil)
    expect(@image.location).to be_a String
    expect(@image.location).to eq(@location.titleize)
    expect(@image.image_url).to be_a String
    expect(@image.image_url).to eq(@attrs[:results].first[:urls][:regular])
    expect(@image.description).to be_a String
    expect(@image.description).to eq(@attrs[:results].first[:description])
    expect(@image.credit).to be_a Hash
    expect(@image.credit).to have_key(:source)
    expect(@image.credit[:source]).to be_a String
    expect(@image.credit).to have_key(:author)
    expect(@image.credit[:author]).to be_a String
    expect(@image.credit).to have_key(:author_profile)
    expect(@image.credit[:author_profile]).to be_a String
  end
  describe 'get_credit' do
    it 'can return the credit from an image' do
      credit = @image.get_credit(@attrs[:results].first)
      expect(credit).to be_a Hash
      expect(credit).to have_key(:source)
      expect(credit[:source]).to be_a String
      expect(credit[:source]).to eq(@attrs[:results].first[:links][:html])
      expect(credit).to have_key(:author)
      expect(credit[:author]).to be_a String
      expect(credit[:author]).to eq(@attrs[:results].first[:user][:name])
      expect(credit).to have_key(:author_profile)
      expect(credit[:author_profile]).to be_a String
      expect(credit[:author_profile]).to eq(@attrs[:results].first[:user][:links][:html])
    end
  end
end
