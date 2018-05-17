Rails.application.routes.draw do
  resources :users
  resources :portfolios
  resources :portfolios, only: [:show] do
    resources [:portfolio_stocks], only [:show, :new]
  end
  resources :categories
  resources :stock_categories
  resources :stocks
  get '/static/missing'
  resources :sessions
  get '/logout' => 'sessions#destroy'

  root 'static#home', as: 'home'

  get 'auth/facebook/callback' => 'sessions#create'

  get 'portfolios/:id/stocks/:stock_id' =>
end
