# frozen_string_literal: true

require_relative "lib/chalky_layout/version"

Gem::Specification.new do |spec|
  spec.name = "chalky_layout"
  spec.version = ChalkyLayout::VERSION
  spec.authors = ["Chalky"]
  spec.email = ["dev@chalky.org"]

  spec.summary = "Simple Rails admin UI components with helper methods"
  spec.description = "A collection of reusable ViewComponents for Rails admin interfaces. " \
                     "Provides headers, dropdowns, buttons, sections, and responsive data grids " \
                     "with simple helper methods like chalky_header, chalky_grid, etc."
  spec.homepage = "https://github.com/ChalkyOrg/chalky_layout"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end

  # Include all files for gems not yet in git
  spec.files = Dir[
    "lib/**/*",
    "app/**/*",
    "config/**/*",
    "README.md",
    "CHANGELOG.md",
    "LICENSE.txt"
  ]

  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 7.0"
  spec.add_dependency "view_component", ">= 3.0"
  spec.add_dependency "slim-rails", ">= 3.0"
  spec.add_dependency "simple_form", ">= 5.0"

  # Optional dependency for pagination support
  # Add gem "pagy", ">= 6.0" to your Gemfile to enable pagination features
end
