Rails.application.routes.draw do
  root 'welcome#index'
  get 'cars/all_cars'
  devise_for :users
  resources :users
  resources :cars

end
