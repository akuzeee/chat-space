class MessagesController < SuperChatsController
  prepend_before_action :set_current_chat_group, only: :index
  before_action :set_message,                    only: :index

  def index
    render 'chat_groups/index'
  end

  def create
    Message.create(message_params)
    redirect_to chat_group_messages_path(params[:chat_group_id])
  end

  private
  def set_current_chat_group
    @chat_group = ChatGroup.includes(messages: :user).find(params[:chat_group_id])
  end

  def set_message
    @message = Message.new
  end

  def message_params
    params.require(:message).permit(:text).merge(chat_group_id: params[:chat_group_id], user_id: current_user.id)
  end
end
