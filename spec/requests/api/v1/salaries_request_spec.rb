require 'rails_helper'

RSpec.describe 'Salaries Search'do
  describe 'happy path' do
    it 'can return certain salaries an current weather of a location' do
      location = 'denver'
      get "/api/v1/salaries?destination=#{location}"
      expect(response).to be_successful
      expect(response.status).to eq(200)
      salaries = JSON.parse(response.body, symbolize_names:true)

      expect(salaries).to be_a(Hash)
      expect(salaries[:data]).to be_a(Hash)
      expect(salaries[:data].count).to eq(3)
      expect(salaries[:data][:id].nil?).to eq true
      expect(salaries[:data][:type]).to eq("salaries")
      expect(salaries[:data][:attributes].count).to eq(3)

      data = salaries[:data][:attributes]

      expect(data).to have_key(:destination)
      expect(data[:destination]).to be_a String
      expect(data).to have_key(:forecast)
      expect(data[:forecast]).to be_a Hash

      forecast = data[:forecast]
      expect(forecast).to have_key(:summary)
      expect(forecast[:summary]).to be_a String
      expect(forecast).to have_key(:temperature)
      expect(forecast[:temperature]).to be_a String

      expect(data).to have_key(:salaries)
      expect(data[:salaries]).to be_an Array
      expect(data[:salaries].count).to eq(7)
      salary1 = data[:salaries].first
      expect(salary1).to have_key(:title)
      expect(salary1[:title]).to be_a String
      expect(salary1).to have_key(:min)
      expect(salary1[:min]).to be_a String
      expect(salary1).to have_key(:max)
      expect(salary1[:max]).to be_a String
    end
  end
  describe "sad path" do
    it "Won't return salaries with missing destination" do
      params = ({
      })

      headers = {"CONTENT_TYPE" => "application/json"}
      get "/api/v1/salaries", headers: headers, params: params

      error = JSON.parse(response.body, symbolize_names:true)
      error_message = "Must provide destination"

      expect(response).to have_http_status(:bad_request)
      expect(error).to have_key(:error)
      expect(error[:error]).to eq("#{error_message}")
    end
    it "Won't return salaries with missing destination" do
      params = ({
        destination: ""
      })

      headers = {"CONTENT_TYPE" => "application/json"}
      get "/api/v1/salaries", headers: headers, params: params

      error = JSON.parse(response.body, symbolize_names:true)
      error_message = "Must provide destination"

      expect(response).to have_http_status(:bad_request)
      expect(error).to have_key(:error)
      expect(error[:error]).to eq("#{error_message}")
    end
  end
end
