class Admin::BaseController < ApplicationController
  before_filter :authenticate_admin

  layout 'admin'

  def authenticate_admin
    redirect_to '/' unless current_refinery_user && current_refinery_user.forem_admin?
  end
end
