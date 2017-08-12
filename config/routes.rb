Rails.application.routes.draw do
  get 'admin/index'

  get 'dashboard/index'

  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  resources :users
    get 'dashboard' => 'dashboard#index'

  controller :sessions do
    get "login" => :new
    post "login" => :create
    get "logout" => :destroy
  end

  root 'dashboard#index'
end
