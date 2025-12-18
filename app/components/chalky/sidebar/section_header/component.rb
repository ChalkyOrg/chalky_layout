# frozen_string_literal: true

module Chalky
  module Sidebar
    module SectionHeader
      class Component < ViewComponent::Base
        attr_reader :title, :description, :icon_path, :icon_color_class, :spacing_classes

        ICON_COLORS = {
          blue: "bg-blue-100 text-blue-600",
          green: "bg-green-100 text-green-600",
          purple: "bg-purple-100 text-purple-600",
          orange: "bg-orange-100 text-orange-600",
          red: "bg-red-100 text-red-600",
          gray: "bg-gray-100 text-gray-600",
          indigo: "bg-indigo-100 text-indigo-600"
        }.freeze

        def initialize(title:, icon_path:, description: nil, icon_color: :blue, spacing: "mb-3")
          super()
          @title = title
          @description = description
          @icon_path = icon_path
          @icon_color_class = ICON_COLORS[icon_color] || ICON_COLORS[:blue]
          @spacing_classes = spacing
        end

        def header_classes
          base_classes = "sidebar-section-header flex items-center gap-3"
          [base_classes, spacing_classes].compact.join(" ")
        end

        def icon_container_classes
          base_classes = "sidebar-section-icon flex-shrink-0 w-8 h-8 flex items-center justify-center rounded-lg"
          [base_classes, icon_color_class].compact.join(" ")
        end
      end
    end
  end
end
