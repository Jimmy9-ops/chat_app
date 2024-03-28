# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
    before_action :set_application_and_chat
    before_action :set_message, only: [:show,:update]

 # GET /applications/:token/chats/:number/messages
 def index
  @messages = @chat.messages
  render json: @messages
end

# GET /applications/:token/chats/:number/messages/:id
def show
  render json: @message
end

# POST /applications/:token/chats/:number/messages
def create

  message = CreateMessageWorker.new.perform(@chat.chat_number,message_params,@application.id)
    if message.present?
      render json: message, status: :created
    else
      render json: { error: 'Failed to create chat' }, status: :unprocessable_entity
    end

=begin
  last_message_number = @chat.messages.maximum(:message_number).to_i  || 0
  number = last_message_number + 1

  @message = @chat.messages.build(message_params.merge(message_number: number))


  if @message.save
    render json: @message, status: :created
  else
    render json: @message.errors, status: :unprocessable_entity
  end
=end
end

# PATCH/PUT /applications/:token/chats/:number/messages/:id
def update
  if @message.update(message_params)
    render json: @message
  else
    render json: @message.errors, status: :unprocessable_entity
  end
end

# DELETE /applications/:token/chats/:number/messages/:id
def destroy
  @message.destroy
  head :no_content
end

def search
    #  @messages = @chat.messages.search(params[:q])
    #  render json: @messages
    search_query = params[:q]
    messages = SearchMessagesJob.perform_now(search_query)
    render json: messages

end

    private

    def set_application_and_chat
      @application = Application.find_by(token: params[:application_id])
      @chat = @application.chats.find_by(chat_number: params[:chat_id])
      render json: { error: 'Application or Chat not found' }, status: :not_found unless @chat
    end

    def set_message
      @message = @chat.messages.find_by(message_number: params[:id])
    end

    def message_params
      params.require(:message).permit(:body)
    end
  end
