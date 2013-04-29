class ApplicationController < ActionController::Base

  def forem_user
    current_refinery_user
  end
  
  helper_method :forem_user, :mobile_device?

  protect_from_forgery
  
  before_filter :prepare_for_mobile

  private

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
  end
end
