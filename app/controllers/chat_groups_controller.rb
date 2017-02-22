class ChatGroupsController < ApplicationController
  def new
    @chat_group = ChatGroup.new
  end

  def create
    chat_group = ChatGroup.new(chat_group_params)
    if chat_group[:name].present?
      chat_group.save
      redirect_to :root, flash: { success: '新規グループを作成しました' }
    else
      redirect_to ({ action: :new }), flash: { warning: 'グループ名を入力してください' }
    end
  end

  def edit
    #TODO: ちゃんと取得する
    @chat_group = ChatGroup.find(1)
  end

  def update
    if chat_group_params[:name].present?
      ChatGroup.find(params[:id]).update(chat_group_params)
      redirect_to :root, flash: { success: 'グループを更新しました' }
    else
      redirect_to ({ action: :new }), flash: { warning: 'グループ名を入力してください' }
    end
  end

  private
  def chat_group_params
    params.require(:chat_group).permit(:name)
  end
end
