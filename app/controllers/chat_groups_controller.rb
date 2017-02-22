class ChatGroupsController < ApplicationController
  def new
    @chat_group = ChatGroup.new
  end

  def create
    if ChatGroup.create(chat_group_params).valid?
      redirect_to :root, flash: { success: '新規グループを作成しました' }
    else
      redirect_to ({ action: :new }), flash: { warning: 'グループ名を入力してください' }
    end
  end

  def edit
    @chat_group = ChatGroup.find(params[:id])
  end

  def update
    if ChatGroup.find(params[:id]).update(chat_group_params)
      redirect_to :root, flash: { success: 'グループを更新しました' }
    else
      redirect_to ({ action: :edit }), flash: { warning: 'グループ名を入力してください' }
    end
  end

  private
  def chat_group_params
    params.require(:chat_group).permit(:name)
  end
end
