Rails.application.routes.draw do
  devise_for :users
  root       'chat_groups#index'
  resources  :chat_groups, except: :destroy
end
