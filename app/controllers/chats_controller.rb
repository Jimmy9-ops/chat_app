# app/controllers/chats_controller.rb
class ChatsController < ApplicationController
  before_action :set_application
  before_action :set_chat, only: [:show, :update, :destroy]

  # GET /applications/:application_token/chats
  def index
    @chats = @application.chats
    render json: @chats
  end

  # GET /applications/:application_token/chats/:id
  def show
    render json: @chat
  end

  # POST /applications/:application_token/chats
  def create

    chat = CreateChatWorker.new.perform(@application.id)
    if chat.present?
      render json: chat, status: :created
    else
      render json: { error: 'Failed to create chat' }, status: :unprocessable_entity
    end

   # last_chat = @application.chats.order(chat_number: :desc).first
   # number = last_chat ? last_chat.chat_number + 1 : 1
   # @chat = @application.chats.new(chat_number: number)
   # if @chat.save
   #   render json: @chat, status: :created
   # else
   #   render json: @chat.errors, status: :unprocessable_entity
   # end

  end

  # PATCH/PUT /applications/:application_token/chats/:id
  def update
    if @chat.update(chat_params)
      render json: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /applications/:application_token/chats/:id
  def destroy
    @chat.destroy
    head :no_content
  end

  private

   def set_application
    @application = Application.find_by(token: params[:application_id])
    if @application.nil?
      render json: { error: 'Application not found' }, status: :not_found
    end
  end

  def set_chat
    return unless @application # Ensure @application is set before proceeding
    @chat = @application.chats.find_by(chat_number: params[:id])
    if @chat.nil?
      render json: { error: 'Chat not found' }, status: :not_found
    end
  end

  # Only allow a trusted parameter "white list" through.
  def chat_params
    params.require(:chat).permit(:number)
  end
end
