Rails.application.routes.draw do
  get 'sessions/new'

  root                'static_pages#home'
  get    'help'    => 'users#help'
  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new' #login page
  post   'login'   => 'sessions#create' #actual log in process
  delete 'logout'  => 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
end
