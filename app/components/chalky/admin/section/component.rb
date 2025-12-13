# frozen_string_literal: true

module Chalky::Admin
  module Section
    class Component < ViewComponent::Base
      renders_one :header_content
      renders_many :dropdown_items, "DropdownItem"

      ICON_COLORS = {
        blue: "bg-blue-100 text-blue-600",
        indigo: "bg-indigo-100 text-indigo-600",
        purple: "bg-purple-100 text-purple-600",
        green: "bg-green-100 text-green-600",
        orange: "bg-orange-100 text-orange-600",
        red: "bg-red-100 text-red-600",
        gray: "bg-gray-100 text-gray-600"
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
            "#{base} text-gray-400 cursor-not-allowed"
          elsif variant == :danger
            "#{base} text-red-600 hover:bg-red-50"
          else
            "#{base} text-gray-700 hover:bg-gray-100"
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
