Rails.application.routes.draw do
  root :to => "welcome#index"
  
  #resources :equipment_categories
  #resources :categories
  #resources :borrows
  #resources :equipment
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:show] do
    resources :equipment, only: [:index, :show, :edit, :update, :destroy]
  end

end
