class ChatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @my_chats = current_user.chats
    @chat_partners = User.where.not(id: current_user.id)
    @chat_partners.order(chat_id: "DESC")
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
    #user = User.find(params[:partner_id])
    @chat = Chat.new(chat_params)
    @chat.save
    #if @chat.save
    #  user.create_notification_chat!(current_user, @chat.id)
    #end
    redirect_to request.referer
  end

  private

  def chat_params
    params.require(:chat).permit(:user_id, :partner_id, :message, :chat_image)
  end
end
