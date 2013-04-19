Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :ideas do
    resources :ideas, :path => '', :only => [:new, :index, :show, :create] do
      resource :votes, :only => [:create]
    end
  end

  # Admin routes
  namespace :ideas, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :ideas, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
