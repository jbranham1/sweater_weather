class Api::V1::SessionsController < ApplicationController
  def create
    params = JSON.parse(request.body.read)
    user = User.create!(params)
    render json: UsersSerializer.new(user), status: :created
  end
end
