class Api::V1::RoadTripController < ApplicationController
  before_action :validate_params

  def create
    trip = RoadTripFacade.get_route(params[:origin], params[:destination])
    render json: RoadtripSerializer.new(trip)
  end

  private

  def validate_params
    if request.body.read.blank?
      render json: { error: "Must provide request body" }, status: :bad_request
    else
      params = JSON.parse(request.body.read, symbolize_names: :true)
      if params[:origin].blank? || params[:destination].blank?
        render json: { error: "Must provide origin and destination" }, status: :bad_request
      elsif !User.find_by(api_key: params[:api_key])
        render json: { error: "Must provide valid API key" }, status: :unauthorized
      end
    end
  end
end
