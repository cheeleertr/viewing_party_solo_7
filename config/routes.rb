Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")


  root "welcome#index"
  get '/register', to: 'users#new', as: 'register_user'
  get "/login", to: "users#login_form"
  post "/login", to: "users#login"

  resources :users, only: [:show, :create, :new] do
    resources :discover, only: [:index]
    resources :movies, only: [:index, :show] do
      resources :viewing_party, only: [:new, :create, :show]
      resources :similar, only: [:index]
    end
  end
end
