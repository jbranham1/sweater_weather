class Api::V1::ForecastController < ApplicationController
  before_action :validate_params
  
  def index
    weather = ForecastFacade.get_forecast(params[:location])
    render json: ForecastSerializer.new(weather)
  end

  private

  def validate_params
    if params[:location].blank?
      render json: { error: "Must provide location" }, status: :bad_request
    end
  end
end
