Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#index'
  get 'signin', to: 'sessions#index'
  get 'signup', to: 'users#new'

  post 'message', to: 'application#create_message'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  mount ActionCable.server, at: '/cable'
end
