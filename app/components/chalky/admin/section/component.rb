# frozen_string_literal: true

module Chalky::Admin
  module Section
    class Component < ViewComponent::Base
      renders_one :header_content
      renders_many :dropdown_items, "DropdownItem"

      ICON_COLORS = {
        blue: "bg-chalky-accent-blue-light text-chalky-accent-blue",
        indigo: "bg-chalky-accent-indigo-light text-chalky-accent-indigo",
        purple: "bg-chalky-accent-purple-light text-chalky-accent-purple",
        green: "bg-chalky-accent-green-light text-chalky-accent-green",
        orange: "bg-chalky-accent-orange-light text-chalky-accent-orange",
        red: "bg-chalky-accent-red-light text-chalky-accent-red",
        gray: "bg-chalky-accent-gray-light text-chalky-accent-gray"
      }.freeze

      attr_reader :title, :subtitle, :icon, :icon_color, :dom_id, :open

      def initialize(title:, icon:, subtitle: nil, icon_color: :blue, dom_id: nil, open: true)
        super()
        @title = title
        @subtitle = subtitle
        @icon = icon
        @icon_color = icon_color.to_sym
        @dom_id = dom_id
        @open = open
      end

      def icon_classes
        ICON_COLORS[@icon_color] || ICON_COLORS[:blue]
      end

      def dropdown?
        dropdown_items.any?
      end

      # Inner class for dropdown items
      class DropdownItem < ViewComponent::Base
        attr_reader :label, :href, :icon, :http_method, :turbo_frame, :disabled, :variant

        def initialize(label:, href: nil, icon: nil, method: :get, turbo_frame: nil, disabled: false, variant: :default)
          super()
          @label = label
          @href = href
          @icon = icon
          @http_method = method
          @turbo_frame = turbo_frame
          @disabled = disabled
          @variant = variant
        end

        def call
          # Rendered directly in the parent template
          content
        end

        def link_classes
          base = "block px-4 py-2 text-sm whitespace-nowrap flex justify-start items-center gap-2"
          if disabled
            "#{base} text-chalky-text-muted cursor-not-allowed"
          elsif variant == :danger
            "#{base} text-chalky-danger hover:bg-chalky-danger-light"
          else
            "#{base} text-chalky-text-secondary hover:bg-chalky-surface-hover"
          end
        end

        def data_attributes
          attrs = {}
          attrs[:turbo_method] = http_method if http_method != :get
          attrs[:turbo_frame] = turbo_frame if turbo_frame
          attrs
        end
      end
    end
  end
end
