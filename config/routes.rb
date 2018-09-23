Rails.application.routes.draw do
  resources :clients
  resources :users
  resources :portfolios, only: [:show] do
    resources :portfolio_stocks, only: [:new, :edit, :create, :update, :destroy]
  end
  resources :categories
  resources :stock_categories
  resources :stocks
  resources :clients, only: [:new, :index, :create, :update, :destroy]
  post '/stocks/next'
  get '/static/missing'
  resources :sessions
  get '/logout' => 'sessions#destroy'

  root 'static#home', as: 'home'

  get 'auth/github/callback' => 'sessions#create'
  post 'auth/github/callback' => 'sessions#create'
  get 'auth/github', as: "github_auth"

  get '/portfolios/update' => 'portfolios#update'
  get '/portfolio_stocks/expensive' => 'portfolio_stocks#expensive'

end
