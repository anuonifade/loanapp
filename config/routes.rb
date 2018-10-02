Rails.application.routes.draw do

  scope '/admin' do
    get '/month-details' => 'admin#month_details', as: 'admin_month_details'
    get '/application-details' => 'admin#application_details', as: 'admin_application_details'
    get '/total-contributions' => 'admin#total_contributions', as: 'admin_total_contributions'
    get '/total-loans' => 'admin#total_loans', as: 'admin_total_loans'
    get '/all-users' => 'admin#all_users', as: 'admin_all_users'
    get '/admin-users' => 'admin#admin_users', as: 'admin_admin_users'
    get '/toggle_user/:id' => 'admin#toggle_user', as: 'activate_deactivate_user'
    get '/approve-loan/:loan_id' => 'admin#approve_loan', as: 'approve_loan'
    get '/decline-loan/:loan_id' => 'admin#decline_loan', as: 'decline_loan'
    get '/loan-details/:loan_id' => 'admin#loan_details', as: 'view_loan_details'
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

  namespace :admin do
    resources :loans, :contributions, :users, :admin_users
  end

  get 'recent-loans' => 'loans#recent_loans'
  get 'notifications' => 'notifications#notifications'
  get 'messages' => 'notifications#messages'
  get 'support' => 'supports#index'
  post 'profiles/:id/edit' => 'profiles#update_profile'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    get 'logout' => :destroy
  end

  root 'dashboards#index'
end
