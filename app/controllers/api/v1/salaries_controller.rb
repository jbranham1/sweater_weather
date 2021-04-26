class Api::V1::SalariesController < ApplicationController
  before_action :validate_params
  def index
    salaries = SalariesFacade.get_salaries(params[:destination])
    render json: SalariesSerializer.new(salaries)
  end

  private

  def validate_params
    if params[:destination].blank?
      render json: { error: "Must provide destination" }, status: :bad_request
    end
  end
end
