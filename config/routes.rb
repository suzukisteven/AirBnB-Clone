Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  # Home Page - Index
  root 'pages#index'

  # Signing in
  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"

  # Creating a new account
  get "/sign_up" => "users#new", as: "sign_up"
  post "/sign_up" => "users#new"

  # Current Users profile page
  get "/profile" => "users#profile" #own dashboard
  get "/profile/:id" => "users#profile/:id"

  # Get/Show create a listing page
  get "/listings/new" => "listings#new"

  # Get/Show individual listing page
  get "/listings/:id" => "listings#show"



  # Other Users profile page - looking at someone else's profile, basic information
  get "/users/:id" => "users#show"

  # Verifying a listing
  post "/verify/:id" => "listings#verify", as: "verify"

  # Google OAuth2.0 callback route
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  resources :listings, :users, :bookings
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
