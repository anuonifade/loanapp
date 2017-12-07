Rails.application.routes.draw do

  scope '/admin' do
    get "/month-details" => "admin#month_details", as: "admin_month_details"
    get "/application-details" => "admin#application_details", as: "admin_application_details"
    get "/total-contributions" => "admin#total_contributions", as: "admin_total_contributions" 
    get "/total-loans" => "admin#total_loans", as: "admin_total_loans"
    get "/all-users" => "admin#all_users", as: "admin_all_users"
  end
  resources :admin
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
  get 'recent-loans' => 'loans#recent_loans'
  get 'notifications' => 'notifications#notifications'
  get 'messages' => 'notifications#messages'
  get 'support' => 'supports#index'

  controller :sessions do
    get "login" => :new
    post "login" => :create
    get "logout" => :destroy
  end

  root 'dashboard#index'
end
