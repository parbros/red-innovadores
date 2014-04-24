class Admin::UsersController < ApplicationController
  def index
    @users = Refinery::User.order('email ASC')
  end

  def destroy
    Refinery::User.find(params[:id]).delete
    redirect_to users_url
  end
end
