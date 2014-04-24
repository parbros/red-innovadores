class Admin::BaseController < ApplicationController
  before_filter :authenticate_admin

  def authenticate_admin
    redirect_to root_url unless current_refinery_user && current_refinery_user.forem_admin?
  end
end
