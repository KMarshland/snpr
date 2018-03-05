Rails.application.routes.draw do

  get 'diseases' => 'diseases#index'
  get 'diseases/:short_form' => 'diseases#show'

  resources :sources, only: [:index, :show]

  resources :documents
  root 'static#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
