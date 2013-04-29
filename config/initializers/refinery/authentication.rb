Devise.setup do |config| 
  config.cas_base_url = "http://auth.redinnovacion.org/"
  # config.cas_base_url = "http://localhost:8888/"
  config.cas_create_user = false
end 

