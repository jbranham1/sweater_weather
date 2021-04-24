class Api::V1::BackgroundController < ApplicationController
  def index
    image = ImageFacade.get_image(params[:location])
    render json: ImageSerializer.new(image)
  end
end
