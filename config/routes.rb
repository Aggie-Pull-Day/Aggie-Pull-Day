Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  get 'errors/not_found'
  get 'errors/internal_server_error'
  resources :groups

  get '/articles', to: 'articles#index'

  get '/student', to: 'articles#student'

  get '/admin', to: 'articles#admin'

  get '/dashboard', to: 'articles#dashboard'

  get '/groups', to: 'groups#_group'

  get '/groups/:id/pull_list' => 'groups#pull_list', as: :pull_list

  # get '/groups/pull_complete' => 'groups#pull_complete', as: :pull_complete

  get '/users/:id/displayqr' => 'users#displayqr', as: :displayqr

  post 'tickets/pull_tickets' => 'tickets#pull_tickets', as: :pull_tickets
  post 'users/update_pull_status' => 'users#update_pull_status', as: :update_pull_status
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  match '/404', to: 'errors#not_found', via: :all
  # Defines the root path route ("/")
  # root "articles#index"
  resources :games
  resources :pull_times
  root to: redirect('/articles')

  resources :users, only: %i[new create destroy edit update show]
  resources :users do
    post :leave_group, on: :member
    post :remove_from_group, on: :member
    post :reassign_group_ownership, on: :member
    # get :join_group, on: :member
  end

  get 'users/:id/join_group', to: 'users#join_group', as: :join_group
  post 'users/:id/join_group', to: 'users#add_to_group', as: :add_to_group

  resources :sessions, only: [:new, :create, :destroy]

  # resources :invites, only: [:new]

  get 'invites/new', to: 'invites#new', as: :new_invite
  post 'invites/new', to: 'invites#create', as: :create_invite
end
