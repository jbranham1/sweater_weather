require 'rails_helper'

RSpec.describe 'Sessions Request' do
  it "can create a new user" do
    user_params = {
      "email": "test@test.com",
      "password": "password",
      "password_confirmation": "password"
    }

    headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
    post "/api/v1/sessions", headers: headers, params: user_params.to_json
    created_user = User.last

    expect(response).to be_successful

    expect(created_user.email).to eq(user_params[:email])

    expect(response.status).to eq(201)
    user = JSON.parse(response.body, symbolize_names: true)
    expect(user).to have_key(:data)
    expect(user[:data]).to be_a Hash

    expect(user[:data]).to have_key(:type)
    expect(user[:data][:type]).to eq("users")

    expect(user[:data]).to have_key(:id)
    expect(user[:data]).to have_key(:attributes)
    expect(user[:data][:attributes]).to be_a Hash
    user1 = user[:data][:attributes]
    expect(user1.keys.count).to eq(2)
    expect(user1).to have_key(:email)
    expect(user1[:email]).to be_a String
    expect(user1).to have_key(:api_key)
    expect(user1[:api_key]).to be_a String
  end

  it "Won't create a new user with a bad email" do
    user_params = {
      "email": "test@",
      "password": "password",
      "password_confirmation": "password"
    }
    headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
    post "/api/v1/sessions", headers: headers, params: user_params.to_json

    error = JSON.parse(response.body, symbolize_names:true)
    error_message = "Validation failed: Email is invalid"

    expect(response).to have_http_status(:bad_request)
    expect(error).to have_key(:error)
    expect(error[:error]).to eq("#{error_message}")
  end

  it "Won't create a new user with missing email" do
    user_params = {
      "password": "password",
      "password_confirmation": "password"
    }
    headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
    post "/api/v1/sessions", headers: headers, params: user_params.to_json

    error = JSON.parse(response.body, symbolize_names:true)
    error_message = "Validation failed: Email can't be blank, Email is invalid"

    expect(response).to have_http_status(:bad_request)
    expect(error).to have_key(:error)
    expect(error[:error]).to eq("#{error_message}")
  end

  it "Won't create a new user with missing password" do
    user_params = ({
      "email": "whatever@example.com"
    })

    headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
    post "/api/v1/sessions", headers: headers, params: user_params.to_json

    error = JSON.parse(response.body, symbolize_names:true)
    error_message = "Validation failed: Password can't be blank"

    expect(response).to have_http_status(:bad_request)
    expect(error).to have_key(:error)
    expect(error[:error]).to eq("#{error_message}")
  end

  it "Won't create a new user with passwords that don't match" do
    user_params = {
      "email": "test@test.com",
      "password": "password",
      "password_confirmation": "password_confirmation"
    }

    headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
    post "/api/v1/sessions", headers: headers, params: user_params.to_json

    error = JSON.parse(response.body, symbolize_names:true)
    error_message = "Validation failed: Password confirmation doesn't match Password"

    expect(response).to have_http_status(:bad_request)
    expect(error).to have_key(:error)
    expect(error[:error]).to eq("#{error_message}")
  end

  it "Won't create a new user that already exists" do
    user_params = {
      "email": "test@test.com",
      "password": "password",
      "password_confirmation": "password"
    }

    headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
    post "/api/v1/sessions", headers: headers, params: user_params.to_json

    post "/api/v1/sessions", headers: headers, params: user_params.to_json

    error = JSON.parse(response.body, symbolize_names:true)
    error_message = "Validation failed: Email has already been taken"

    expect(response).to have_http_status(:bad_request)
    expect(error).to have_key(:error)
    expect(error[:error]).to eq("#{error_message}")
  end
end
