require "sidekiq/web"
Rails.application.routes.draw do
  get 'developers/index'

  mount Sidekiq::Web => "/sidekiq" if Rails.env.development?
  root to: "home#index"

  devise_for :users
  resources :directors
  resources :movies
  resources :genres


  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  get "developers", to: "developers#index"
  post "developers", to: "developers#create_api_key"
end
