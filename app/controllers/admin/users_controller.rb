class Admin::UsersController < Admin::BaseController
  def index
    @users = Refinery::User.order('email ASC')
  end

  def destroy
    Refinery::User.delete(params[:id])
    redirect_to admin_users_url
  end
end
