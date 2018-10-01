class MessagesController < ApplicationController
  before_action :find_message, only: [:show]

  def index
    @messages = Message.all

    render json: @messages, status: :ok
  end

  def show
    render json: @message, status: :ok
  end

  def create
    @todo = Message.create!(message_params)

    render json: @todo, status: :created
  end

  private

  def message_params
    params.permit(:name, :email, :subject)
  end

  def find_message
    @message = Message.find(params[:id])

  rescue ActiveRecord::RecordNotFound => error
    render json: { message: error.message }, status: :not_found
  end
end
