module Admin::BaseHelper

  def dashboard_active
    "active" if controller_name == 'dashboard'
  end

  def user_active
    "active" if controller_name == 'users'
  end

  def blog_active
    "active" if controller_name == 'posts'
  end

  def course_active
    "active" if controller_name == 'courses'
  end
end
