Rails.application.routes.draw do
  resources :groups
  
  get "/articles", to: "articles#index"

  get "/student", to: "articles#student"

  get "/admin", to: "articles#admin"

  get "/groups", to: "groups#_group"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :games
    root :to => redirect('/games')

    
end
