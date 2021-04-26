require 'rails_helper'

RSpec.describe "Teleport Search" do
  it "returns salaries of a location" do
    location = "denver"
    response = TeleportService.find_salaries(location)

    expect(response).to be_a Hash
    expect(response).to have_key(:_links)
    expect(response[:_links]).to be_a Hash
    expect(response).to have_key(:salaries)
    expect(response[:salaries]).to be_an Array

    salary1 = response[:salaries].first
    expect(salary1).to be_a Hash

    expect(salary1).to have_key(:job)
    expect(salary1[:job]).to be_a Hash
    expect(salary1[:job]).to have_key(:id)
    expect(salary1[:job][:id]).to be_a String
    expect(salary1[:job]).to have_key(:title)
    expect(salary1[:job][:title]).to be_a String
    expect(salary1).to have_key(:salary_percentiles)
    expect(salary1[:salary_percentiles]).to be_a Hash
    expect(salary1[:salary_percentiles]).to have_key(:percentile_25)
    expect(salary1[:salary_percentiles][:percentile_25]).to be_a Float
    expect(salary1[:salary_percentiles]).to have_key(:percentile_50)
    expect(salary1[:salary_percentiles][:percentile_50]).to be_a Float
    expect(salary1[:salary_percentiles]).to have_key(:percentile_75)
    expect(salary1[:salary_percentiles][:percentile_75]).to be_a Float
  end

  describe "sad path" do
    xit "returns an empty hash if location is empty" do
      location = ""
      response = TeleportService.find_salaries(location)
      expect(response.status).to eq(404)
      expect(response.response_body).to eq("Sorry, but the page you were trying to view does not exist.")
    end
  end
end
