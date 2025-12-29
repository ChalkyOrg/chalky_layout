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

    # Include helpers in views automatically
    initializer "chalky_layout.helpers" do
      config.to_prepare do
        ActionController::Base.helper ChalkyLayoutHelper
      end
    end

    # Configure ViewComponent
    initializer "chalky_layout.view_component" do
      ActiveSupport.on_load(:view_component) do
        # ViewComponent will find components in autoload paths
      end
    end

    # Configure assets for both Propshaft (Rails 8+) and Sprockets (Rails 6/7)
    initializer "chalky_layout.assets" do |app|
      # Common paths for both asset pipelines
      stylesheets_path = root.join("app", "assets", "stylesheets")
      javascript_path = root.join("app", "javascript")

      if defined?(Propshaft)
        # Rails 8+ with Propshaft
        # Propshaft uses config.assets.paths to find assets
        app.config.assets.paths << stylesheets_path
        app.config.assets.paths << javascript_path
      end

      if defined?(Sprockets)
        # Rails 6/7 with Sprockets
        app.config.assets.paths << stylesheets_path
        app.config.assets.paths << javascript_path
        app.config.assets.paths << root.join("app", "assets", "config")

        # Precompile all ChalkyLayout stylesheets
        app.config.assets.precompile += %w[
          chalky_layout/tokens.css
          chalky_layout/utilities.css
          chalky_layout/forms.css
          chalky_layout/sidebar.css
          chalky_layout/tabs.css
          chalky_layout/grid.css
          chalky_layout_manifest.js
        ]
      end

      # Fallback for apps that don't use Propshaft or Sprockets directly
      # but still have an assets configuration (rare edge case)
      if !defined?(Propshaft) && !defined?(Sprockets) && app.config.respond_to?(:assets)
        app.config.assets.paths << stylesheets_path
        app.config.assets.paths << javascript_path
      end
    end

    # Register importmap paths - let the gem's importmap.rb handle the pins
    initializer "chalky_layout.importmap", before: "importmap" do |app|
      if app.config.respond_to?(:importmap)
        # Add gem's importmap.rb to the paths that will be loaded
        app.config.importmap.paths << root.join("config/importmap.rb")
        # Add cache sweeper for development auto-reload
        app.config.importmap.cache_sweepers << root.join("app/javascript")
      end
    end
  end
end
