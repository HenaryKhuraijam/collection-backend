Rails.application.routes.draw do
  devise_for :users,
              controllers: {
                sessions: 'users/sessions',
                registrations: 'users/registrations'
              },
              path: 'users',
              path_names: { sign_in: 'login', sign_out: 'logout', registration: 'register' }
end

