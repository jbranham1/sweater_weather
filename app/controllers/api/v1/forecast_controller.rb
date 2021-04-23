class Api::V1::ForecastController < ApplicationController
  def index
    weather = ForecastFacade.get_forecast(params[:location])
    render json: ForecastSerializer.new(weather)
  end
end
