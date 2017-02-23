Rails.application.routes.draw do
  devise_for :users
  root      'messages#index'
  resources :messages, only: :index
  resources :chat_groups, only: [:new, :edit, :create, :update]
end
