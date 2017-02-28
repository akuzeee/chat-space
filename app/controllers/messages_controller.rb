class MessagesController < ApplicationController
  before_action :set_all_chat_groups,    only: :index
  before_action :set_current_chat_group, only: :index
  before_action :reject_nonmember,       only: :index

  def index
    render 'chat_groups/index'
  end

  private
  def set_all_chat_groups
    @chat_groups = current_user.chat_groups.order(created_at: :desc)
  end

  def set_current_chat_group
    @chat_group = ChatGroup.find(params[:chat_group_id])
  end

  def reject_nonmember
    redirect_to :root unless current_user.join_in?(@chat_group)
  end
end
