Rails.application.routes.draw do
  devise_for :users
  root "events#index"
  resources :events
  post '/enrollments', to: 'enrollments#create', as: 'create_enrollment'
  delete '/enrollments/:id', to: 'enrollments#destroy', as: 'destroy_enrollment'  
end
