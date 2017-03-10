Rails.application.routes.draw do
  resources :users, except: %i(index create new edit show update destroy) do
    collection do
      get :search, format: 'json'
    end
  end
  devise_for :users
  root       'chat_groups#index'
  resources  :chat_groups, except: %i(show destroy) do
    resources :messages, only: %i(index create)
  end
end
