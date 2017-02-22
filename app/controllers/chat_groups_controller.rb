class ChatGroupsController < ApplicationController
  def new
    @chat_group = ChatGroup.new
  end

  def create
    @chat_group = ChatGroup.new(chat_group_params)
    if @chat_group.save
      redirect_to root_path, flash: { success: '新規グループを作成しました' }
    else
      redirect_to new_chat_group_path, flash: { warning: 'グループ名を入力してください' }
    end
  end

  def edit
    @chat_group = ChatGroup.find(params[:id])
  end

  def update
    chat_group = ChatGroup.find(params[:id])
    if chat_group.update(chat_group_params)
      redirect_to root_path, flash: { success: 'グループを更新しました' }
    else
      redirect_to edit_chat_group_path, flash: { warning: 'グループ名を入力してください' }
    end
  end

  private
  def chat_group_params
    params.require(:chat_group).permit(:name)
  end
end
