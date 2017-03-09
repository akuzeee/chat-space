Rails.application.routes.draw do
  get 'users/search' => 'users#search', format: 'json'
  devise_for :users
  root       'chat_groups#index'
  resources  :chat_groups, except: %i(show destroy) do
    resources :messages, only: %i(index create)
  end
end
