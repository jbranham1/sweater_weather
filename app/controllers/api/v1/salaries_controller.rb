class Api::V1::SalariesController < ApplicationController
  def index
    salaries = SalariesFacade.get_salaries(params[:destination])
    render json: SalariesSerializer.new(salaries)
  end
end
