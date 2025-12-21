# frozen_string_literal: true

module Chalky
  module Sidebar
    module SectionHeader
      class Component < ViewComponent::Base
        attr_reader :title, :description, :icon_path, :icon_color_class, :spacing_classes

        ICON_COLORS = {
          blue: "bg-chalky-accent-blue-light text-chalky-accent-blue",
          green: "bg-chalky-accent-green-light text-chalky-accent-green",
          purple: "bg-chalky-accent-purple-light text-chalky-accent-purple",
          orange: "bg-chalky-accent-orange-light text-chalky-accent-orange",
          red: "bg-chalky-accent-red-light text-chalky-accent-red",
          gray: "bg-chalky-accent-gray-light text-chalky-accent-gray",
          indigo: "bg-chalky-accent-indigo-light text-chalky-accent-indigo"
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
