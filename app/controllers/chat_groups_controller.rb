class ChatGroupsController < ApplicationController
  before_action :set_chat_group,   only: %i(show edit update)
  before_action :set_chat_groups,  only: %i(show index)
  before_action :set_users,        only: %i(new edit create update)
  before_action :reject_nonmember, only: %i(show edit)

  def index
  end

  def show
    render :index
  end

  def new
    @chat_group = ChatGroup.new
  end

  def create
    @chat_group = ChatGroup.new(chat_group_params)
    if @chat_group.save
      redirect_to chat_group_path(@chat_group), notice: '新規グループを作成しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @chat_group.update(chat_group_params)
      redirect_to chat_group_path(@chat_group), notice: 'グループを更新しました'
    else
      render :edit
    end
  end

  private
  def set_chat_group
    @chat_group = ChatGroup.find(params[:id])
  end

  def set_chat_groups
    @chat_groups = current_user.chat_groups.order(created_at: :desc)
  end

  def set_users
    @users = User.all
  end

  def chat_group_params
    params.require(:chat_group).permit(:name, user_ids: [])
  end

  def reject_nonmember
    redirect_to :root unless GroupMember.exists?(chat_group_id: params[:id], user_id: current_user.id)
  end
end
