Rails.application.routes.draw do
  resources :users
  resources :portfolios
  resources :portfolios, only: [:show] do
    resources :portfolio_stocks, only: [:new, :edit, :create, :update, :destroy]
  end
  resources :categories
  resources :stock_categories
  resources :stocks
  get '/static/missing'
  resources :sessions
  get '/logout' => 'sessions#destroy'

  root 'static#home', as: 'home'

  get 'auth/github/callback' => 'sessions#create'
  post 'auth/github/callback' => 'sessions#create'
  get 'auth/github', as: "github_auth"

  post '/portfolios/update' => 'portfolios#update'

end
