Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Loan
  get '/loan/new', to: 'loan#new'
  post '/loan/new', to: 'loan#create'

  # Item
  get '/item/new', to: 'item#new'
  post '/item/new', to: 'item#create'

  root 'loan#index'
end
