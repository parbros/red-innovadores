Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :experiences do
    resources :experiences, :path => '', :only => [:index, :show, :create, :new]
  end

  # Admin routes
  namespace :experiences, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :experiences, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
