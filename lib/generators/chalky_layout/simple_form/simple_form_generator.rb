# frozen_string_literal: true

require "rails/generators"
require "rails/generators/base"

module ChalkyLayout
  module Generators
    class SimpleFormGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      desc "Install ChalkyLayout Simple Form configuration with custom styled inputs"

      def check_simple_form
        say "Checking for Simple Form...", :green

        unless gem_installed?("simple_form")
          say "Simple Form gem is required. Add it to your Gemfile:", :red
          say "  gem 'simple_form'"
          raise Thor::Error, "Missing dependency: simple_form"
        end

        say "Simple Form found", :green
      end

      def create_simple_form_initializer
        say ""
        say "Creating Simple Form configuration...", :green
        template "simple_form.rb", "config/initializers/simple_form.rb"
      end

      def show_stylesheet_instructions
        say ""
        say "=" * 60, :green
        say "  ChalkyLayout Simple Form installed!", :green
        say "=" * 60, :green
        say ""
        say "Add the forms stylesheet to your application:", :yellow
        say ""

        if using_propshaft?
          say "  In your application.css or layout:", :cyan
          say "  @import \"chalky_layout/forms\";"
          say ""
          say "  Or link it directly:", :cyan
          say "  = stylesheet_link_tag \"chalky_layout/forms\""
        elsif using_sprockets?
          say "  In app/assets/stylesheets/application.css:", :cyan
          say "  *= require chalky_layout/forms"
        else
          say "  @import \"chalky_layout/forms\";", :cyan
        end

        say ""
        say "Usage example:", :yellow
        say ""
        say "  = simple_form_for @model do |f|"
        say "    = f.input :name"
        say "    = f.input :email"
        say "    = f.input :role, collection: ['Admin', 'User'], as: :radio_buttons"
        say "    = f.input :terms, as: :boolean"
        say "    = f.button :submit"
        say ""
        say "All inputs are styled automatically - no extra classes needed!", :green
        say ""
      end

      private

      def gem_installed?(gem_name)
        Gem.loaded_specs.key?(gem_name) ||
          File.read(Rails.root.join("Gemfile")).include?(gem_name)
      rescue StandardError
        false
      end

      def using_propshaft?
        defined?(Propshaft) || File.exist?(Rails.root.join("config/initializers/propshaft.rb"))
      end

      def using_sprockets?
        defined?(Sprockets) && !using_propshaft?
      end
    end
  end
end
