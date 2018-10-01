class MessagesController < ApplicationController
  before_action :find_message, only: [:show]
  before_action :create_message, only: [:create]

  def index
    @messages = Message.all

    render json: @messages, status: :ok
  end

  def show
    render json: @message, status: :ok
  end

  def create
    GenericMailer.with(@message).email.deliver_later

    render json: @message, status: :created
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

  def create_message
    @message = Message.create!(message_params)

  rescue ActiveRecord::RecordInvalid => error
    render json: { message: error.message }, status: :unprocessable_entity
  end
end
