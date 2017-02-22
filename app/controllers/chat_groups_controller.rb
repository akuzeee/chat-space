class ChatGroupsController < ApplicationController
  def new
    @chat_group = ChatGroup.new
  end

  def create
    ChatGroup.create(chat_group_params)
    redirect_to :root and return
  end

  def edit
    #TODO: ちゃんと取得する
    @chat_group = ChatGroup.find(1)
  end

  def update
    ChatGroup.find(params[:id]).update(chat_group_params)
    redirect_to :root and return
  end

  private
  def chat_group_params
    params.require(:chat_group).permit(:name)
  end
end
