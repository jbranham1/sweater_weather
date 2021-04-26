class Api::V1::SalariesController < ApplicationController
  def index
    salaries = Salaries.new(params[:destination])

    render json: SalariesSerializer.new(salaries)
  end
end
