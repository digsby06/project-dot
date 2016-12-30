require 'sidekiq/web'
Rails.application.routes.draw do
  resources :tweets

  # devise_for :users, path_names: { sign_in: 'signin', sign_out: 'signout' },
  #                  controllers: { omniauth_callbacks: 'omniauth_callbacks',
  #                                 registrations: 'registrations' }
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => "registrations"}

  resources :users
  resources :entries
  resources :displays
  resources :authentications, only: [:destroy]

  root 'page#dashboard'
  get  '/preview' => 'page#previewmode'
  get '/test' => 'page#test'

  mount Sidekiq::Web, at: '/sidekiq'
end
