class Admin::UsersController < Admin::BaseController
  def index
    @users = Refinery::User.order('email ASC').paginate(page: params[:page] || 1)
    @courses = RemoteCourse.get_courses.select {|course| course['account_id'] == 3}
  end

  def destroy
    Refinery::User.delete(params[:id])
    redirect_to admin_users_url
  end

  def bulk_subscribe_to_courses
    @users = Refinery::User.find(param[:ids])
    @users.each do |user|
      user.enroll_to_course params[:course_id]
    end

    redirect_to admin_users_url
  end
end
