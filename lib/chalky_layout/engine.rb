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

    # Add JavaScript assets to asset pipeline and declare precompilation
    initializer "chalky_layout.assets", before: "importmap" do |app|
      if app.config.respond_to?(:assets)
        # Add JS path to asset pipeline
        app.config.assets.paths << root.join("app", "javascript")
        # Declare assets for precompilation
        app.config.assets.precompile += %w[chalky_layout/**/*.js]
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
