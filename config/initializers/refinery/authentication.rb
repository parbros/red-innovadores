Devise.setup do |config|

  if Rails.env.production?
    config.cas_base_url = "http://auth.redinnovacion.org/"
  else
    config.cas_base_url = "http://localhost:8888/"
  end

  config.cas_create_user = false
end

