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
      class_option :skip_claude, type: :boolean, default: false,
                                 desc: "Skip Claude Code skill installation"

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

      def setup_stimulus_controllers
        return if options[:skip_stimulus]

        say ""

        if using_importmap?
          say "Stimulus controllers are automatically available via importmap.", :green
          say ""
          say "Register them in app/javascript/controllers/index.js:", :yellow
          say ""
          say "  import DropdownController from 'controllers/chalky_layout/dropdown_controller'"
          say "  import GridController from 'controllers/chalky_layout/grid_controller'"
          say "  import BackController from 'controllers/chalky_layout/back_controller'"
          say "  import StopPropagationController from 'controllers/chalky_layout/stop_propagation_controller'"
        else
          say "Copying Stimulus controllers for JS bundler...", :green
          controllers_source = ChalkyLayout::Engine.root.join("app/javascript/chalky_layout/controllers")

          %w[dropdown_controller.js grid_controller.js back_controller.js stop_propagation_controller.js].each do |file|
            copy_file controllers_source.join(file), "app/javascript/controllers/#{file}"
          end

          say ""
          say "Register them in app/javascript/controllers/index.js:", :yellow
          say ""
          say "  import DropdownController from './dropdown_controller'"
          say "  import GridController from './grid_controller'"
          say "  import BackController from './back_controller'"
          say "  import StopPropagationController from './stop_propagation_controller'"
        end

        say ""
        say "  application.register('dropdown', DropdownController)"
        say "  application.register('grid', GridController)"
        say "  application.register('back', BackController)"
        say "  application.register('stop-propagation', StopPropagationController)"
        say ""
      end

      def setup_tailwind
        say ""
        say "Configuring Tailwind CSS...", :green

        if tailwind_v4?
          setup_tailwind_v4
        else
          setup_tailwind_v3
        end
      end

      def show_tailwind_colors
        say ""
        say "Ensure these colors are defined in your Tailwind config:", :yellow
        say ""
        say "  primary, secondary, light, content, contrast, midgray, contour"
        say ""
      end

      def setup_claude_skill
        return if options[:skip_claude]

        say ""
        skill_dir = Rails.root.join(".claude", "skills", "chalky-layout")
        skill_file = skill_dir.join("SKILL.md")
        reference_file = skill_dir.join("reference.md")

        if File.exist?(skill_file)
          say "Claude Code skill already installed at .claude/skills/chalky-layout/", :green
          say "Updating reference.md only (SKILL.md preserved)...", :cyan

          # Only update reference.md, preserve user's SKILL.md customizations
          FileUtils.mkdir_p(skill_dir)
          template "claude_skill/reference.md", reference_file, force: true

          say "Reference documentation updated.", :green
        else
          say "Installing Claude Code skill...", :green

          FileUtils.mkdir_p(skill_dir)
          template "claude_skill/SKILL.md", skill_file
          template "claude_skill/reference.md", reference_file

          say "Claude Code skill installed at .claude/skills/chalky-layout/", :green
          say ""
          say "Claude Code will now automatically use chalky_layout helpers", :cyan
          say "for any frontend work (views, templates, components, etc.)", :cyan
        end
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
        say "  UI:         chalky_badge, chalky_stat, chalky_tooltip, chalky_hint"
        say "  UI:         chalky_alert, chalky_info_row, chalky_tabs, chalky_dropdown"
        say "  Sidebar:    chalky_sidebar_container, chalky_sidebar_section"
        say "  Sidebar:    chalky_sidebar_section_header, chalky_sidebar_menu_item"
        say "  Sidebar:    chalky_sidebar_footer"
        say ""

        unless options[:skip_claude]
          say "Claude Code Integration:", :yellow
          say "  A skill has been installed at .claude/skills/chalky-layout/"
          say "  Claude will automatically use these helpers for frontend work."
          say ""
        end
      end

      private

      def gem_installed?(gem_name)
        Gem.loaded_specs.key?(gem_name) ||
          File.read(Rails.root.join("Gemfile")).include?(gem_name)
      rescue StandardError
        false
      end

      def using_importmap?
        File.exist?(Rails.root.join("config/importmap.rb"))
      end

      def tailwind_v4?
        # Check for Tailwind v4 indicators
        css_config = Rails.root.join("app/assets/stylesheets/application.tailwind.css")
        return false unless File.exist?(css_config)

        content = File.read(css_config)
        content.include?("@import \"tailwindcss\"") || content.include?("@theme")
      end

      def setup_tailwind_v3
        config_path = Rails.root.join("tailwind.config.js")

        unless File.exist?(config_path)
          say "tailwind.config.js not found, skipping automatic configuration", :yellow
          show_manual_tailwind_v3_instructions
          return
        end

        content = File.read(config_path)

        # Check if already configured
        if content.include?("chalky_layout") || content.include?("getChalkyLayoutPath")
          say "Tailwind already configured for ChalkyLayout", :green
          return
        end

        # Add the dynamic path resolution at the top
        path_resolver = <<~JS

          const { execSync } = require('child_process')

          // Dynamically find the chalky_layout gem path
          function getChalkyLayoutPath() {
            try {
              const gemPath = execSync('bundle show chalky_layout', { encoding: 'utf-8' }).trim()
              return gemPath
            } catch (e) {
              console.warn('Could not find chalky_layout gem path')
              return null
            }
          }

          const chalkyLayoutPath = getChalkyLayoutPath()

        JS

        # Insert after the first require statement
        if content.match?(/^const .+ = require\(.+\)/)
          content = content.sub(/(^const .+ = require\(.+\)\n)/) do |match|
            # Find all consecutive require statements
            if content.match?(/^(const .+ = require\(.+\)\n)+/m)
              content.match(/^(const .+ = require\(.+\)\n)+/m)[0] + path_resolver
            else
              match + path_resolver
            end
          end
        else
          content = path_resolver + content
        end

        # Add content paths
        content_paths = <<~JS
    // ChalkyLayout gem components (path resolved dynamically via `bundle show`)
            ...(chalkyLayoutPath ? [
              `${chalkyLayoutPath}/app/components/**/*.{rb,erb,html,slim}`,
              `${chalkyLayoutPath}/app/helpers/**/*.rb`,
            ] : []),
        JS

        # Find the content array and add paths
        if content.match?(/content:\s*\[/)
          # Add after the opening bracket of content array
          content = content.sub(/(content:\s*\[\n?)/) do |match|
            "#{match}#{content_paths}"
          end

          File.write(config_path, content)
          say "Updated tailwind.config.js with ChalkyLayout paths", :green
        else
          say "Could not find content array in tailwind.config.js", :yellow
          show_manual_tailwind_v3_instructions
        end
      end

      def setup_tailwind_v4
        css_path = Rails.root.join("app/assets/stylesheets/application.tailwind.css")

        unless File.exist?(css_path)
          say "application.tailwind.css not found", :yellow
          show_manual_tailwind_v4_instructions
          return
        end

        content = File.read(css_path)

        # Check if already configured
        if content.include?("chalky_layout")
          say "Tailwind v4 already configured for ChalkyLayout", :green
          return
        end

        gem_path = ChalkyLayout::Engine.root

        source_directive = <<~CSS

          /* ChalkyLayout gem components */
          @source "#{gem_path}/app/components/**/*.{rb,slim}";
        CSS

        # Add after @import "tailwindcss" or at the beginning
        if content.match?(/@import ["']tailwindcss["']/)
          content = content.sub(/(@import ["']tailwindcss["'];?\n?)/) do |match|
            match + source_directive
          end
        else
          content = source_directive + content
        end

        File.write(css_path, content)
        say "Updated application.tailwind.css with ChalkyLayout source", :green
      end

      def show_manual_tailwind_v3_instructions
        say ""
        say "Add this to the top of your tailwind.config.js:", :yellow
        say ""
        say "  const { execSync } = require('child_process')"
        say ""
        say "  function getChalkyLayoutPath() {"
        say "    try {"
        say "      return execSync('bundle show chalky_layout', { encoding: 'utf-8' }).trim()"
        say "    } catch (e) { return null }"
        say "  }"
        say ""
        say "  const chalkyLayoutPath = getChalkyLayoutPath()"
        say ""
        say "Then add to your content array:", :yellow
        say ""
        say "  ...(chalkyLayoutPath ? ["
        say "    `${chalkyLayoutPath}/app/components/**/*.{rb,erb,html,slim}`,"
        say "    `${chalkyLayoutPath}/app/helpers/**/*.rb`,"
        say "  ] : []),"
        say ""
      end

      def show_manual_tailwind_v4_instructions
        say ""
        say "Add this to your application.tailwind.css:", :yellow
        say ""
        say "  @source \"#{ChalkyLayout::Engine.root}/app/components/**/*.{rb,slim}\";"
        say ""
      end
    end
  end
end
