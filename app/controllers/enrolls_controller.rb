class EnrollsController < ApplicationController

  def create
    @course = Course.get_course params[:course_id]
    @course.enrolls.create(user_id: current_refinery_user.id)
    redirect_to aprendizaje_show_url(@course.remote_courses_id)
  end
end
