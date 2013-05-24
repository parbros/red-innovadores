class PasswordsController < Devise::PasswordsController
  def new
    super
  end

  def create
    super
  end
  
  def devise_mapping
    Devise.mappings[:refinery_user]
  end
  helper_method :devise_mapping
end