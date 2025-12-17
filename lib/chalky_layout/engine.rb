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
    # Use config.to_prepare to ensure the helper is autoloaded before being included
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

    # Add JavaScript path for asset pipeline BEFORE importmap registration
    initializer "chalky_layout.assets", before: "importmap" do |app|
      if app.config.respond_to?(:assets)
        app.config.assets.paths << root.join("app", "javascript")
      end
    end

    # Register Stimulus controllers with importmap using relative paths
    initializer "chalky_layout.importmap", after: "importmap" do |app|
      if app.respond_to?(:importmap) && app.importmap
        # Pin each controller using relative path (served by asset pipeline)
        controllers_path = root.join("app/javascript/chalky_layout/controllers")
        Dir[controllers_path.join("*_controller.js")].each do |controller_file|
          controller_name = File.basename(controller_file, ".js")
          # Use relative path that will be resolved by asset pipeline
          app.importmap.pin "controllers/chalky_layout/#{controller_name}",
                            to: "chalky_layout/controllers/#{controller_name}.js"
        end
      end
    end
  end
end
