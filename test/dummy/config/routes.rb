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
  get "simple_form" => "showcase#simple_form", as: :simple_form
  post "simple_form" => "showcase#create_form_demo", as: :create_form_demo
  get "ajax_select" => "showcase#ajax_select", as: :ajax_select
  get "search_countries" => "showcase#search_countries", as: :search_countries

  # Dummy routes for grid actions demo
  get "users/:id/edit" => "showcase#index", as: :edit_user
  get "users/:id" => "showcase#index", as: :user
  delete "users/:id" => "showcase#index", as: :delete_user
  delete "logout" => "showcase#index", as: :logout
end
