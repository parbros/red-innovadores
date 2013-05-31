class PasswordsController < Devise::PasswordsController
  def new
    super
  end

  def create
    self.resource = Refinery::Memberships::Member.send_reset_password_instructions(params[resource_name])

    if successfully_sent?(resource)
      respond_with({}, :location => after_sending_reset_password_instructions_path_for(resource_name))
    else
      respond_with(resource)
    end
    
  end
  
  def update
    self.resource = resource_class.reset_password_by_token(params[resource_name])

    if resource.errors.empty?
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message(:notice, flash_message) if is_navigational_format?
      respond_with resource, :location => after_sign_in_path_for(resource)
    else
      respond_with resource
    end
  end
  
  def after_sign_in_path_for(resource_name)
    '/'
  end
  
  def after_sending_reset_password_instructions_path_for(resource_name)
    '/'
  end
  
  def devise_mapping
    Devise.mappings[:refinery_user]
  end
  helper_method :devise_mapping
end