class Api::V1::UsersController < ApplicationController
  before_action :validate_params

  def create
    params = JSON.parse(request.body.read, symbolize_names: true)
    if params[:password_confirmation].blank?
      render json: { error: "Must provide password confirmation" }, status: :bad_request
    else
      user = User.create!(params)
      render json: UsersSerializer.new(user), status: :created
    end
  end

  private

  def validate_params
    if request.body.read.blank?
      render json: { error: "Must provide request body" }, status: :bad_request
    end
  end
end
