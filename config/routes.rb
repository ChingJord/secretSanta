Rails.application.routes.draw do

  root "members#index"

  resources :members

  devise_for :users

end
