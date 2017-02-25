class ChatGroupsController < ApplicationController
  before_action :set_new_chat_group,        only: %i(new create)
  before_action :set_existing_chat_group,   only: %i(show edit update)
  before_action :set_chat_group_attributes, only: %i(create update)
  before_action :set_chat_groups,           only: %i(show index)
  before_action :set_users,                 only: %i(new edit create update)
  before_action :reject_nonmember,          only: %i(show edit)

  def index
  end

  def show
    render :index
  end

  def new
  end

  def create
    if includes_current_user? && @chat_group.save
      redirect_to chat_group_path(@chat_group), notice: '新規グループを作成しました'
    else
      prepare_error_message
      render :new
    end
  end

  def edit
  end

  def update
    if includes_current_user? && @chat_group.save
      redirect_to chat_group_path(@chat_group), notice: 'グループを更新しました'
    else
      prepare_error_message
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
    redirect_to :root unless current_user.join_in?(@chat_group)
  end

  def includes_current_user?
    @chat_group.users.include?(current_user)
  end

  def prepare_error_message
      @chat_group.valid?
      @chat_group.errors.add(:member, 'にご自身を加えて下さい') unless includes_current_user?
  end
end
