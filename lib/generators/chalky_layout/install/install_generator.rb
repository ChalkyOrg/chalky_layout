# frozen_string_literal: true

require "rails/generators"
require "rails/generators/base"

module ChalkyLayout
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      desc "Install ChalkyLayout: configures Stimulus controllers and Tailwind"

      class_option :skip_stimulus, type: :boolean, default: false,
                                   desc: "Skip Stimulus controller installation"

      def check_dependencies
        say "Checking dependencies...", :green

        unless gem_installed?("view_component")
          say "ViewComponent gem is required. Add it to your Gemfile:", :red
          say "  gem 'view_component'"
          raise Thor::Error, "Missing dependency: view_component"
        end

        unless gem_installed?("slim-rails") || gem_installed?("slim")
          say "Slim templates are required. Add to your Gemfile:", :red
          say "  gem 'slim-rails'"
          raise Thor::Error, "Missing dependency: slim-rails"
        end

        say "All dependencies found", :green
      end

      def create_initializer
        say "Creating initializer...", :green
        template "initializer.rb", "config/initializers/chalky_layout.rb"
      end

      def show_stimulus_setup
        return if options[:skip_stimulus]

        say ""
        say "Stimulus controllers are automatically available via importmap.", :green
        say ""
        say "Register them in app/javascript/controllers/index.js:", :yellow
        say ""
        say "  import DropdownController from 'controllers/chalky_layout/dropdown_controller'"
        say "  import GridController from 'controllers/chalky_layout/grid_controller'"
        say "  import BackController from 'controllers/chalky_layout/back_controller'"
        say "  import StopPropagationController from 'controllers/chalky_layout/stop_propagation_controller'"
        say ""
        say "  application.register('dropdown', DropdownController)"
        say "  application.register('grid', GridController)"
        say "  application.register('back', BackController)"
        say "  application.register('stop-propagation', StopPropagationController)"
        say ""
      end

      def show_tailwind_config
        say "Add these colors to your tailwind.config.js:", :yellow
        say ""
        say "  theme: {"
        say "    extend: {"
        say "      colors: {"
        say "        primary: '#3b82f6',"
        say "        secondary: '#6b7280',"
        say "        light: '#f9fafb',"
        say "        content: '#374151',"
        say "        contrast: '#111827',"
        say "        midgray: '#6b7280',"
        say "        contour: '#e5e7eb',"
        say "      }"
        say "    }"
        say "  }"
        say ""
        say "  Also ensure your content array includes:", :yellow
        say "    Gem path: '#{ChalkyLayout::Engine.root.join('app/components/**/*.{rb,slim}')}'"
        say ""
      end

      def show_post_install_message
        say ""
        say "=" * 60, :green
        say "  ChalkyLayout installed successfully!", :green
        say "=" * 60, :green
        say ""
        say "Helper methods are now available in your views:", :cyan
        say ""
        say "  = chalky_page do |page|"
        say "    - page.with_header_bar do"
        say "      = chalky_title_bar(title: 'My Page')"
        say ""
        say "  = chalky_grid(rows: @users) do |grid|"
        say "    - grid.text(label: 'Name', method: :name)"
        say ""
        say "Available helpers:", :yellow
        say "  Page:       chalky_page, chalky_title_bar, chalky_actions, chalky_content"
        say "  Data:       chalky_grid"
        say "  Containers: chalky_panel, chalky_card, chalky_heading"
        say "  Buttons:    chalky_button, chalky_icon_button, chalky_back"
        say "  Other:      chalky_dropdown"
        say ""
      end

      private

      def gem_installed?(gem_name)
        Gem.loaded_specs.key?(gem_name) ||
          File.read(Rails.root.join("Gemfile")).include?(gem_name)
      rescue StandardError
        false
      end
    end
  end
end
