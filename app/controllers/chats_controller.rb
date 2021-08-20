class ChatsController < ApplicationController
  def index
    @my_chats = current_user.chats
    @chat_partners = User.where.not(id: current_user.id)

  end

  def show
    @chat_partner = User.find(params[:id])
    @chats_by_myself = Chat.where(user_id: current_user.id, partner_id: @chat_partner.id)
    @chats_by_other = Chat.where(user_id: @chat_partner.id, partner_id: current_user.id)
    @chats = @chats_by_myself.or(@chats_by_other)
    @chats = @chats.order(:created_at)


    @chat_message = Chat.new
  end

  def create
    chat = Chat.new(chat_params)
    chat.save
    redirect_to request.referer
  end

  private
  def chat_params
    params.require(:chat).permit(:user_id, :partner_id, :message, :chat_image)
  end
end
