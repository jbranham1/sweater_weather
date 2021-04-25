class Api::V1::RoadTripController < ApplicationController
  def create
    params = JSON.parse(request.body.read, symbolize_names: :true)
    if params[:origin].blank? || params[:destination].blank?
      render json: { error: "Must provide origin and destination" }, status: :bad_request
    else
      trip = RoadTripFacade.get_route(params[:origin], params[:destination])
      render json: RoadtripSerializer.new(trip)
    end
  end
end
