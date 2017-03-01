class ChatGroupsController < SuperChatsController
  prepend_before_action :set_existing_chat_group,   only: %i(edit update)
  skip_before_action :reject_nonmember,     only: :index
  before_action :set_new_chat_group,        only: %i(new create)
  before_action :set_chat_group_attributes, only: %i(create update)
  before_action :set_users,                 only: %i(new edit create update)

  def index
    render 'layouts/groups'
  end

  def new
  end

  def create
    if includes_current_user? && @chat_group.save
      redirect_to chat_group_messages_path(@chat_group), notice: '新規グループを作成しました'
    else
      prepare_error_message
      render :new
    end
  end

  def edit
  end

  def update
    if includes_current_user? && @chat_group.save
      redirect_to chat_group_messages_path(@chat_group), notice: 'グループを更新しました'
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

  def set_users
    @users = User.all
  end

  def chat_group_params
    params.require(:chat_group).permit(:name, user_ids: [])
  end

  def includes_current_user?
    @chat_group.users.include?(current_user)
  end

  def prepare_error_message
      @chat_group.valid?
      @chat_group.errors.add(:member, 'にご自身を加えて下さい') unless includes_current_user?
  end
end
