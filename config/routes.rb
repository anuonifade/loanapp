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
    get '/reset_password/:id' => 'admin#reset_password', as: 'reset_user_password'
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
  get 'clear-balance/:id/deposit' => 'loan#clear_balance_by_deposit', as: 'clear_loan_deposit'
  get 'clear-balance/:id/savings' => 'loan#clear_balance_by_savings', as: 'clear_loan_savings'
  get 'all-loans' => 'loan#all_loan', as: 'all_loans'
  get 'password-reset' => 'sessions#password_reset', as: 'password_reset'
  get 'password-reset/:token' => 'sessions#authenticate_token', as: 'password_reset_token'
  post 'password-reset' => 'sessions#password_reset_email', as: 'password_reset_email'
  get 'resend-reset-email' => 'sessions#resend_reset_email', as: 'resend_password_reset_email'
  post 'change-password' => 'sessions#change_password', as: 'change_password'
  post 'profiles/upload-passport' => 'profiles#upload_passport', as: 'upload_passport'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    get 'logout' => :destroy
  end

  root 'dashboards#index'
end
