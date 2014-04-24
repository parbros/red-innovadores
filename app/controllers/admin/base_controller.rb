class Admin::BaseController < ApplicationController
  before_filter :authenticate_admin

  def authenticate_admin
    redirect_to root_url unless refinery_current_user && refinery_current_user.forem_admin?
  end
end
