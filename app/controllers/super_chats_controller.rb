class SuperChatsController < ApplicationController
  before_action :set_all_chat_groups,  only: :index
  before_action :reject_nonmember,     only: %i(index edit)

  private
  def set_all_chat_groups
    @chat_groups = current_user.chat_groups.order(created_at: :desc)
  end

  def reject_nonmember
    redirect_to :root unless current_user.join_in?(@chat_group)
  end
end
