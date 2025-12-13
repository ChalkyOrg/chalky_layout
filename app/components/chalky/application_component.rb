# frozen_string_literal: true

##
# Base class for all UI Kit ViewComponents
# See: https://viewcomponent.org/
#
# To generate a new component: https://viewcomponent.org/guide/generators.html
class Chalky::ApplicationComponent < ViewComponent::Base
  include ActionView::RecordIdentifier

  private

  def component_config
    @component_config ||= load_component_config
  end

  def load_component_config
    config_path = component_config_path
    return {} unless config_path && File.exist?(config_path)

    full_config = YAML.load_file(config_path)
    current_locale = I18n.locale.to_s

    # Return configuration for current locale, fallback to 'en', then empty hash
    full_config[current_locale] || full_config["en"] || {}
  rescue StandardError => e
    Rails.logger.warn "Failed to load component config from #{config_path}: #{e.message}"
    {}
  end

  def component_config_path
    # Convert component class name to config file path
    component_path = self.class.name.underscore.gsub("/component", "")
    Rails.root.join("app", "components", component_path.to_s, "component.yml")
  end
end
