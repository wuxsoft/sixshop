Rails.application.routes.draw do
  namespace :admin do
    get 'role/edit'
  end

  namespace :admin do
    get 'role/index'
  end

  namespace :admin do
    get 'role/new'
  end

  namespace :admin do
    get 'role/show'
  end

  namespace :admin do
    get 'rols/index'
  end

  namespace :admin do
    get 'rols/new'
  end

  namespace :admin do
    get 'rols/destory'
  end

  namespace :admin do
    get 'home/index'
  end

  devise_for :users
  get 'home/index'
  get 'home/about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
  root :to => "home#index"
end
