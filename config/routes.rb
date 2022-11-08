Rails.application.routes.draw do
  root 'welcome#index'
  get 'cars/location'
  get 'cars/all_cars'
  get 'users/pdf/:id' ,to: 'users#pdf' ,as: 'user_pdf'
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks",
                                   sessions: 'users/sessions',}
  resources :users
  get "cars/success", to: "cars#success"
  resources :cars do
    member do
      get 'payment'
    end
  end
  post "checkout/create", to: "checkout#create"
  devise_scope :user do
    get '/phone_otp', to: 'users/sessions#phone_otp'
    post '/phone_otp', to: 'users/sessions#phone_otp_verify'
  end

end
