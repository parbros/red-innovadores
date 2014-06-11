RedInnovadores::Application.routes.draw do

  # This line mounts Refinery's routes at the root of your application.
  # This means, any requests to the root URL of your application will go to Refinery::PagesController#home.
  # If you would like to change where this extension is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Refinery relies on it being the default of "refinery"

  match '/administrador' => redirect('/refinery')

  match '/registro' => 'refinery/memberships/members#new'

  resources :comunidad, only: [:index], controller: :community
  resources :cursos, only: [:index, :update], controller: :courses
  resources :add_points, only: [:index]
  resources :comments, only: [:destroy]

  match '/aprendizaje' => 'learning#index'
  match '/aprendizaje/:id' => 'learning#show', as: :aprendizaje_show
  match '/aprendizaje/:course_id/inscripcion' => 'enrolls#create', as: :enrolls, method: :post

  namespace :admin do
    root to: 'dashboard#index'
    delete '/users', to: 'users#destroy'
    post '/users/bulk_subscribe_to_courses', to: 'users#bulk_subscribe_to_courses'
    resources :users, only: [:index, :destroy]
    resources :posts
    resources :courses do
      resources :enrolls
    end
  end

  post '/tinymce_assets' => 'tinymce_assets#create'

  resources :passwords, :except => :destroy

  get 'sign_in', :to => 'refinery/cas_sessions#new', :as => :new_session

  mount Forem::Engine, :at => "/foros"
  mount Refinery::Core::Engine, :at => '/'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
