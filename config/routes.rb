Rails.application.routes.draw do
  namespace :practitioner_dashboard do
    get "licenses/show"
    get "licenses/create"
    get "licenses/success"
    get "licenses/cancel"
  end
  # registrations
  get "registrations/patient"
  get "registrations/practitioner"
  post "registrations/create_user", to: "registrations#create_user", as: :practitioner_registration

  # dashboard root
  get "practitioner_dashboard", to: "practitioner_dashboard/dashboard#index",
      as: :practitioner_dashboard

  # everything under /practitioner_dashboard/... lives in that folder
  namespace :practitioner_dashboard, path: "practitioner_dashboard" do
    resource :practitioner_profile, only: [ :show, :edit, :update ]
    resources :practitioner_availabilities

    resource :license, only: [ :show, :create ] do
      post :cancel_subscription, on: :collection
      get :success
      get :cancel
    end

    resources :holidays, only: [ :create, :destroy ]
  end


  resource :session
  resources :passwords, param: :token
  get "pages/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "pages#index"
end
