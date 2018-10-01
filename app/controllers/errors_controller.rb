class ErrorsController < ApplicationController
  before_action :parse_query_params

  def index
    if @type.present?
      @errors = Error.where(failure_type: @type)
    else
      @errors = Error.all
    end

    render json: @errors, status: :ok
  end

  private

  def parse_query_params
    @type = params[:type]
  end
end
