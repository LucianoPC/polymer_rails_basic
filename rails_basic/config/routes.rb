Rails.application.routes.draw do
  resources :users
  match 'users/login', to: 'users#login', via: [:post]
  match 'users/logout', to: 'users#logout', via: [:post]
  match 'users/edit', to: 'users#edit', via: [:post]
  match 'users/get_user', to: 'users#get_user', via: [:post]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
