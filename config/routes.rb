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

  match '/resend_confirmation' => 'refinery/memberships/members#resend_confirmation'

  match '/sso' => 'discourse_sso#sso'

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

  mount Refinery::Core::Engine, :at => '/'

end
