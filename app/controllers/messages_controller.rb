class MessagesController < ApplicationController
  before_action :set_all_chat_groups,    only: :index
  before_action :set_current_chat_group, only: :index
  before_action :reject_nonmember,       only: :index
  before_action :set_message,            only: :index

  def index
    render 'chat_groups/index'
  end

  def create
    Message.create(message_params)
    redirect_to chat_group_messages_path(params[:chat_group_id])
  end

  private
  def set_all_chat_groups
    @chat_groups = current_user.chat_groups.order(created_at: :desc)
  end

  def set_current_chat_group
    @chat_group = ChatGroup.find(params[:chat_group_id])
  end

  def reject_nonmember
    redirect_to :root unless current_user.join_in?(@chat_group)
  end

  def set_message
    @message = Message.new
  end

  def message_params
    params.require(:message).permit(:text).merge(chat_group_id: params[:chat_group_id], user_id: current_user.id)
  end
end
