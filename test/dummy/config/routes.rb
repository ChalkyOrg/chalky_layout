Rails.application.routes.draw do
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Component showcase routes
  root "showcase#index"
  get "feedback" => "showcase#feedback", as: :feedback
  get "navigation" => "showcase#navigation", as: :navigation
  get "layout" => "showcase#layout", as: :layout
  get "buttons" => "showcase#buttons", as: :buttons
  get "data" => "showcase#data", as: :data

  # Dummy routes for grid actions demo
  get "users/:id/edit" => "showcase#index", as: :edit_user
  get "users/:id" => "showcase#index", as: :user
  delete "users/:id" => "showcase#index", as: :delete_user
  delete "logout" => "showcase#index", as: :logout
end
