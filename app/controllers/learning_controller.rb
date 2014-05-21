class LearningController < ApplicationController

  def index
    @courses = Course.get_courses
  end

  def show
    @course = Course.get_course params[:id]
  end
end
