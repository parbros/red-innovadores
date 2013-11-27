Refinery::Core::Engine.routes.append do

  # Admin routes
  namespace :gamifications, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :gamifications, only: [:index]
    end
  end

end
