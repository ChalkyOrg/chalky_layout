# frozen_string_literal: true

module Chalky::AdminForms
  module Dropdown
    module Item
      class Component < ViewComponent::Base
        attr_reader :href, :icon, :css_classes, :data_attributes, :variant, :type, :method, :confirm

        def initialize(**options)
          super()
          # Extract main parameters with defaults
          @type = (options.delete(:type) || :link).to_sym
          @href = options.delete(:href)
          @icon = options.delete(:icon)
          @css_classes = options.delete(:css_classes) || ""
          @variant = (options.delete(:variant) || :admin).to_sym
          @method = options.delete(:method) || :get
          # Handle both confirm and turbo_confirm
          @confirm = options.delete(:confirm) || options.delete(:turbo_confirm)

          # Remaining options become data attributes
          @data_attributes = options
        end

        def item_classes
          base_classes = case type
                         when :divider
                           "w-full h-px px-4 border-b border-solid border-chalky-border border-x-0 border-t-0"
                         when :text
                           "w-full text-left px-4 py-2 text-sm font-medium"
                         when :button
                           "w-full text-left px-4 py-2 text-sm transition-colors duration-150"
                         else # :link
                           "block px-4 py-2 text-sm whitespace-nowrap flex justify-start items-center transition-colors duration-150"
                         end

          variant_classes = case variant
                            when :danger
                              type == :text ? "text-chalky-danger-text" : "text-chalky-danger hover:bg-chalky-danger-light"
                            when :primary
                              type == :text ? "text-chalky-primary-text" : "text-chalky-primary hover:bg-chalky-primary-light"
                            else # :admin or any other value
                              type == :text ? "text-chalky-text-primary" : "text-chalky-text-secondary hover:bg-chalky-surface-hover"
                            end
          [base_classes, variant_classes, css_classes].compact.join(" ")
        end

        def item_data
          base_data = { role: "menuitem", tabindex: "-1" }
          # Use turbo_confirm for Turbo compatibility with links too
          base_data[:turbo_confirm] = confirm if confirm.present?

          # Transform any turbo_frame attribute to data-turbo-frame
          transformed_attrs = {}
          data_attributes.each do |key, value|
            transformed_attrs[key.to_s == "turbo_frame" ? :turbo_frame : key] = value
          end

          base_data.merge(transformed_attrs)
        end

        def button_data
          base_data = {}
          # Use turbo_confirm for Turbo compatibility
          base_data[:turbo_confirm] = confirm if confirm.present?
          # Ensure we don't disable turbo unless explicitly set
          merged_data = base_data.merge(data_attributes)
          # Remove turbo: false if it exists to ensure Turbo Stream works
          merged_data.delete(:turbo) if merged_data[:turbo] == false
          merged_data
        end

        def icon_classes
          "mr-2 text-current"
        end

        def button_options
          options = {
            class: item_classes,
            role: "menuitem",
            tabindex: "-1"
          }
          options[:method] = method if method != :get
          options[:data] = button_data if data_attributes.any? || confirm.present?
          options
        end

        def link_options
          options = {
            class: item_classes,
            role: "menuitem",
            tabindex: "-1"
          }
          # Build data attributes hash
          data_hash = {}
          data_hash[:turbo_confirm] = confirm if confirm.present?

          # Add transformed data attributes
          data_attributes.each do |key, value|
            data_hash[key.to_s == "turbo_frame" ? :turbo_frame : key] = value
          end

          options[:data] = data_hash if data_hash.any?
          options
        end
      end
    end
  end
end
