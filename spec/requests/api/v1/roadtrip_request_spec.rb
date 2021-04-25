require 'rails_helper'

RSpec.describe 'Roadtrip Request' do
  before :each do
    @user = User.create(email: 'email@test.com', password: 'password')
  end

  it "can create a new roadtrip" do
    VCR.use_cassette("roadtrip") do
      params = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": @user.api_key
      }

      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
      post "/api/v1/road_trip", headers: headers, params: params, as: :json

      expect(response).to be_successful

      expect(response.status).to eq(200)
      trip = JSON.parse(response.body, symbolize_names: true)
      expect(trip).to have_key(:data)
      expect(trip[:data]).to be_a Hash

      expect(trip[:data]).to have_key(:type)
      expect(trip[:data][:type]).to eq("roadtrip")

      expect(trip[:data]).to have_key(:id)
      expect(trip[:data][:id]).to eq(nil)
      expect(trip[:data]).to have_key(:attributes)
      expect(trip[:data][:attributes]).to be_a Hash
      attributes = trip[:data][:attributes]
      expect(attributes.keys.count).to eq(4)
      expect(attributes).to have_key(:start_city)
      expect(attributes[:start_city]).to be_a String
      expect(attributes).to have_key(:end_city)
      expect(attributes[:end_city]).to be_a String
      expect(attributes).to have_key(:travel_time)
      expect(attributes[:travel_time]).to be_a String
      expect(attributes).to have_key(:weather_at_eta)
      expect(attributes[:weather_at_eta]).to be_a Hash
      expect(attributes).to have_key(:start_city)
      expect(attributes[:start_city]).to be_a String
      expect(attributes).to have_key(:end_city)
      expect(attributes[:end_city]).to be_a String
      expect(attributes).to have_key(:start_city)
      expect(attributes[:start_city]).to be_a String
      expect(attributes[:weather_at_eta]).to have_key(:temperature)
      expect(attributes[:weather_at_eta][:temperature]).to be_a Float
      expect(attributes[:weather_at_eta]).to have_key(:conditions)
      expect(attributes[:weather_at_eta][:conditions]).to be_a String
    end
  end

  it "won't create a new roadtrip with no origin" do
    VCR.use_cassette("roadtrip_no_origin") do
      params = {
        "destination": "Pueblo,CO",
        "api_key": @user.api_key
      }

      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
      post "/api/v1/road_trip", headers: headers, params: params, as: :json

      error = JSON.parse(response.body, symbolize_names:true)
      error_message = error[:error]

      expect(response).to have_http_status(:bad_request)
      expect(error).to have_key(:error)
      expect(error[:error]).to eq("#{error_message}")
    end
  end

  it "won't create a new roadtrip with no destination" do
    VCR.use_cassette("roadtrip_no_destination") do
      params = {
        "origin": "Pueblo,CO",
        "api_key": @user.api_key
      }

      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
      post "/api/v1/road_trip", headers: headers, params: params, as: :json

      error = JSON.parse(response.body, symbolize_names:true)
      error_message = error[:error]

      expect(response).to have_http_status(:bad_request)
      expect(error).to have_key(:error)
      expect(error[:error]).to eq("#{error_message}")
    end
  end

  it "won't create a new roadtrip with an overseas trip" do
    VCR.use_cassette("roadtrip_overseas") do
      params = {
        "origin": "Denver,CO",
        "destination": "London,UK",
        "api_key": @user.api_key
      }

      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
      post "/api/v1/road_trip", headers: headers, params: params, as: :json

      expect(response).to be_successful

      expect(response.status).to eq(200)
      trip = JSON.parse(response.body, symbolize_names: true)
      expect(trip).to have_key(:data)
      expect(trip[:data]).to be_a Hash

      expect(trip[:data]).to have_key(:type)
      expect(trip[:data][:type]).to eq("roadtrip")

      expect(trip[:data]).to have_key(:id)
      expect(trip[:data][:id]).to eq(nil)
      expect(trip[:data]).to have_key(:attributes)
      expect(trip[:data][:attributes]).to be_a Hash
      attributes = trip[:data][:attributes]
      expect(attributes.keys.count).to eq(4)
      expect(attributes).to have_key(:start_city)
      expect(attributes[:start_city]).to be_a String
      expect(attributes).to have_key(:end_city)
      expect(attributes[:end_city]).to be_a String
      expect(attributes).to have_key(:travel_time)
      expect(attributes[:travel_time]).to be_a String
      expect(attributes[:travel_time]).to eq("impossible")
      expect(attributes).to have_key(:weather_at_eta)
      expect(attributes[:weather_at_eta]).to be_a Hash
      expect(attributes[:weather_at_eta].empty?).to be true
    end
  end
end
