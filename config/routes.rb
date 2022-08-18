Rails.application.routes.draw do

  root "home/home#front"

  resources :roles, controller: "users/roles"
  resources :notices, controller: "notice/notices"

  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }

  get '/profile', to: 'users/members#show'
  namespace :users do
    patch ':id/role', to: 'users#update_role'
    resources :roles
    resources :users, path: '/', except: %i[create]
  end
end
