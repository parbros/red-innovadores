class Admin::CoursesController < Admin::BaseController

  def index
    @courses = Course.get_courses
  end

  def show
    @course = Course.get_course params[:id]
  end

  def update
    @course = Course.get_course params[:id]
    @course.update_attributes(params[:course])
    redirect_to admin_course_url(@course.remote_courses_id)
  end
end
