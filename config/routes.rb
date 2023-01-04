Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :forecasts, only: [:new, :show, :create]

  # Defines the root path route ("/")
  root "forecasts#new"
end
