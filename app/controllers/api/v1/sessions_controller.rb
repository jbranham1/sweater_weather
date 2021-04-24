class Api::V1::SessionsController < ApplicationController
  def create
    params = JSON.parse(request.body.read, symbolize_names: :true)
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: UsersSerializer.new(user)
    else
      render json: { error: "Credentials are bad" }, status: :bad_request
    end
  end
end
