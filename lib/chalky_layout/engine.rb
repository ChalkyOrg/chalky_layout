# frozen_string_literal: true

module ChalkyLayout
  class Engine < ::Rails::Engine
    # Don't isolate namespace - we want helpers available globally

    # Add the gem's components to autoload/eager_load paths
    config.autoload_paths << root.join("app", "components")
    config.eager_load_paths << root.join("app", "components")

    # Ensure components are available
    initializer "chalky_layout.autoload", before: :set_autoload_paths do |app|
      app.config.autoload_paths << root.join("app", "components")
      app.config.eager_load_paths << root.join("app", "components")
    end

    # Include helpers in views automatically - use action_controller for reliability
    initializer "chalky_layout.helpers" do
      ActiveSupport.on_load(:action_controller_base) do
        helper ChalkyLayoutHelper
      end
    end

    # Configure ViewComponent
    initializer "chalky_layout.view_component" do
      ActiveSupport.on_load(:view_component) do
        # ViewComponent will find components in autoload paths
      end
    end

    # Register Stimulus controllers with importmap
    initializer "chalky_layout.importmap", before: "importmap" do |app|
      if app.respond_to?(:importmap)
        app.importmap.pin_all_from(
          root.join("app/javascript/chalky_layout/controllers"),
          under: "controllers/chalky_layout"
        )
      end
    end

    # Add JavaScript path for asset pipeline (Sprockets/Propshaft)
    initializer "chalky_layout.assets" do |app|
      if app.config.respond_to?(:assets)
        app.config.assets.paths << root.join("app", "javascript")
      end
    end
  end
end
