class Admin::UsersController < Admin::BaseController
  def index
    @users = Refinery::User.order('email ASC')
  end

  def destroy
    @users = Refinery::User.find(params[:id])
    @users.is_a? Array ? @users.map(&:delete) : @users.delete
    redirect_to admin_users_url
  end
end
