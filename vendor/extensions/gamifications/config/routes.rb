Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :gamifications do
    resources :gamifications, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :gamifications, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :gamifications, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
