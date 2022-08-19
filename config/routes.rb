Rails.application.routes.draw do

  # Homepage of the api
  root "home/home#home"

  # This route is for handling error
  match "/404", to: "application#handlenotfound", via: :all

  # resources creater for roles and notices
  resources :roles, controller: "users/roles"
  resources :notices, controller: "notice/notices"

  # This will generate devise routes
  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }

  # route to see the current user profile
  get '/profile', to: 'users/members#show'

  # This creates routes for users folder
  namespace :users do
    patch ':id/role', to: 'users#update_role'
    resources :roles
    resources :users, path: '/', except: %i[create]
  end
end
