Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :subs
  resources :posts, except: [:index]
  resources :comments, only: [:new, :create]
end
