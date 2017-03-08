class MessagesController < ApplicationController
  layout        'main_view'
  before_action :set_chat_group,      only: %i(index create)
  before_action :set_all_chat_groups, only: %i(index create)
  before_action :set_message,         only: :index
  before_action :reject_nonmember,    only: :index

  def index
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      respond_to do |format|
        format.html { redirect_to chat_group_messages_path(@chat_group), notice: '新しいメッセージが投稿されました！' }
        format.json { render json: @message.to_builder.target! }
      end
    else
      flash.now[:alert] = 'メッセージを入力してください'
      render :index
    end
  end

  private
  def set_chat_group
    @chat_group = ChatGroup.includes(messages: :user).find(params[:chat_group_id])
  end

  def set_message
    @message = Message.new
  end

  def message_params
    params.require(:message).permit(:text).merge(chat_group_id: params[:chat_group_id], user_id: current_user.id)
  end
end
