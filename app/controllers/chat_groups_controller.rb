class ChatGroupsController < ApplicationController
  def new
    @chat_group = ChatGroup.new
  end

  def create
    ChatGroup.create(create_params)
    redirect_to :root and return
  end

  def edit
    #TODO: ちゃんと取得する
    @chat_group = ChatGroup.find(1)
  end

  def update
    ChatGroup.find(params[:id]).update(update_params)
    redirect_to :root and return
  end

  private
  def create_params
    params.require(:chat_group).permit(:name)
  end

  def update_params
    params.require(:chat_group).permit(:name)
  end
end
