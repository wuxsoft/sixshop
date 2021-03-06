Rails.application.routes.draw do
  namespace :admin do
    resources :roles
    resources :home
    resources :users
    root :to => "users#index"
  end

  devise_for :users
  get 'home/index'
  get 'home/about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
  root :to => "home#index"
end
