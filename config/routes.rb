Rails.application.routes.draw do
  resources :roles, controller: "users/roles"
  resources :notices, controller: "notice/notices"
  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }
  get '/profile', to: 'users/members#show'
end
