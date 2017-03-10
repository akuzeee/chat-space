class UsersController < ApplicationController
  def search
    @users = User.search_by_name(params[:keyword])
  end
end
