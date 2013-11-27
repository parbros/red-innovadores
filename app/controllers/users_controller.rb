class UsersController < ApplicationController
  
  def index
    @users = Refinery::User.all
  end
  
  def destroy
    Refinery::User.find(params[:id]).delete
    redirect_to users_url
  end
end
