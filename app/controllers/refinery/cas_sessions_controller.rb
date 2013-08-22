class Refinery::CasSessionsController < Devise::CasSessionsController
  
  def service
    if current_refinery_user && current_refinery_user.has_role?(:superuser)
      redirect_to after_sign_in_path_for(warden.authenticate!(:scope => resource_name))
    else
      warden.authenticate!(:scope => resource_name)
      redirect_to root_url
    end
  end
end