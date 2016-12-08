Rails.application.routes.draw do
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

end
