class UsersController < ApplicationController
  def search
    @searched_users = User.search_by_name(params[:q])
  end
end
