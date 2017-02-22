class ChatGroupsController < ApplicationController
  before_action :set_chat_group, only: [:edit, :update]

  def new
    @chat_group = ChatGroup.new
  end

  def create
    @chat_group = ChatGroup.new(chat_group_params)
    if @chat_group.save
      redirect_to root_path, notice: '新規グループを作成しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @chat_group.update(chat_group_params)
      redirect_to root_path, notice: 'グループを更新しました'
    else
      render :edit
    end
  end

  private
  def set_chat_group
    @chat_group = ChatGroup.find(params[:id])
  end

  def chat_group_params
    params.require(:chat_group).permit(:name)
  end
end
