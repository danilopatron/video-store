Rails.application.routes.draw do
  devise_for :users
  resources :videos do
  	resources :reviews
  end

  root 'videos#index'
end
