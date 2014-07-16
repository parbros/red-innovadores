Refinery::Core::Engine.routes.append do

  # Admin routes
  namespace :covers, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :covers, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

  match "/refinery/users/:id/edit" => 'refinery/admin/users#delete', as: 'memberships_admin_member'
end
