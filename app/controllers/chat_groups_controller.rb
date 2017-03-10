class ChatGroupsController < ApplicationController
  layout        'main_view',                only: :index
  before_action :set_all_chat_groups,       only: :index
  before_action :set_existing_chat_group,   only: %i(edit update)
  before_action :set_new_chat_group,        only: %i(new create)
  before_action :set_chat_group_attributes, only: %i(create update)
  before_action :set_users,                 only: %i(new edit create update)
  before_action :reject_nonmember,          only: :edit

  def index
  end

  def new
  end

  def create
    if @chat_group.save
      redirect_to chat_group_messages_path(@chat_group), notice: '新規グループを作成しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @chat_group.save
      redirect_to chat_group_messages_path(@chat_group), notice: 'グループを更新しました'
    else
      render :edit
    end
  end

  private
  def set_new_chat_group
    @chat_group = ChatGroup.new
  end

  def set_existing_chat_group
    @chat_group = ChatGroup.find(params[:id])
  end

  def set_chat_group_attributes
    @chat_group.assign_attributes(chat_group_params)
  end

  def set_users
    @users = User.all
  end

  def chat_group_params
    params.require(:chat_group).permit(:name, user_ids: [])
  end
end
