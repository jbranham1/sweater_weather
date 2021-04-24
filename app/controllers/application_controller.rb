class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record

  def render_invalid_record(exception)
    render json: { error: exception.message }, status: :bad_request
  end
end
