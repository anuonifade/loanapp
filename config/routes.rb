Rails.application.routes.draw do

  resources :contributions
  resources :loans
  resources :officers
  resources :witnesses
  resources :guarantors
  resources :bank_details
  resources :roles
  resources :profiles
  resources :loan_types
  resources :users
    get 'dashboard' => 'dashboard#index'

  controller :sessions do
    get "login" => :new
    post "login" => :create
    get "logout" => :destroy
  end

  root 'dashboard#index'
end
