Rails.application.routes.draw do
  devise_for :users
  root "chats#index"
  resources :chats, only: [:index, :create]
  resources :groups, only: [:new, :create, :edit, :update, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
