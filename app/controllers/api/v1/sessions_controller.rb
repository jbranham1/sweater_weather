class Api::V1::SessionsController < ApplicationController
  before_action :validate_params

  def create
    params = JSON.parse(request.body.read, symbolize_names: true)
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      render json: UsersSerializer.new(user)
    else
      render json: { error: "Credentials are bad" }, status: :bad_request
    end
  end

  private

  def validate_params
    if request.body.read.blank?
      render json: { error: "Must provide request body" }, status: :bad_request
    end
  end
end
