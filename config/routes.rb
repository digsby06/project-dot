Rails.application.routes.draw do
  resources :entries
  resources :displays
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => "registrations"}
  # get '/callback' => 'page#callback'
  root 'page#dashboard'

  # devise_scope :user do
  #   get '/sign-in' => "devise/sessions#new", :as => :login
  # end
resources :authentications, only: [:destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
