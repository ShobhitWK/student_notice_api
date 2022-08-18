Rails.application.routes.draw do
  resources :roles
  resources :notices
  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }
  get '/profile', to: 'members#show'
end
