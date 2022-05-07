Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  get 'errors/not_found'
  get 'errors/internal_server_error'
  resources :groups

  get "/articles", to: "articles#index"

  get "/student", to: "articles#student"

  get "/admin", to: "articles#admin"

  get '/dashboard', to: 'articles#dashboard'

  get "/groups", to: "groups#_group"

  get '/users/display' => 'users#display'

  get '/users/displayqr' => 'users#displayqr'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  match "/404", to: "errors#not_found", via: :all
  # Defines the root path route ("/")
  # root "articles#index"
  resources :games
  root to: redirect('/articles')

  resources :users, only: [:new, :create, :destroy, :edit, :update, :show]
  resources :users do
    post :leave_group, on: :member
    post :remove_from_group, on: :member
    # get :join_group, on: :member
  end

  get 'users/:id/join_group', to: 'users#join_group', as: :join_group
  post 'users/:id/join_group', to: 'users#add_to_group', as: :add_to_group

  resources :sessions, only: [:new, :create, :destroy]
end
