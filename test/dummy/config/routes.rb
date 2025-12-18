Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "showcase#index"
  get "showcase" => "showcase#index"

  # Admin routes with sidebar
  get "admin" => "admin#index", as: :admin
  get "admin/orders" => "admin#index", as: :admin_orders
  get "admin/products" => "admin#index", as: :admin_products
  get "admin/users" => "admin#index", as: :admin_users
  get "admin/roles" => "admin#index", as: :admin_roles
  get "admin/settings" => "admin#index", as: :admin_settings
  get "admin/integrations" => "admin#index", as: :admin_integrations
  get "admin/profile" => "admin#index", as: :admin_profile
  delete "logout" => "admin#index", as: :logout

  # Dummy routes for grid actions demo
  get "users/:id/edit" => "showcase#index", as: :edit_user
  get "users/:id" => "showcase#index", as: :user
  delete "users/:id" => "showcase#index", as: :delete_user
end
