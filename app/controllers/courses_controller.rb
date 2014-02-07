class CoursesController < ApplicationController
  def index
    @courses = current_refinery_user.get_courses
  end
end
