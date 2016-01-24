Rails.application.routes.draw do

  root "layouts#index"

  resources :members

  devise_for :users

end
