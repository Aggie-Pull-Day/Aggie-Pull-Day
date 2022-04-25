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

  get "/groups", to: "groups#_group"

  get '/users/display' => 'users#display'
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
  end
  resources :sessions, only: [:new, :create, :destroy]
end
