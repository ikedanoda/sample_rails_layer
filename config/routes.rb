Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'root#show'

  resource :registration, only: [:show, :create] do
    member do
      post :confirm
    end
  end
end
