Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "150494841794659", "f73d40803e4deb52af325c2bd58a6ac8"
  provider :twitter, "mnadEbTL7ALQ6xI5eW4Heg", "FEg8dxGthM7hetX1CKp9WRvZpqsnpAihM6rcadTVk"
end