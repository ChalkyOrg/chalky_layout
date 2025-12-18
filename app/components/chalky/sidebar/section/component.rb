# frozen_string_literal: true

module Chalky
  module Sidebar
    module Section
      class Component < ViewComponent::Base
        # Section with header and menu items
        # Auto-generates the ul structure for menu items
        renders_many :menu_items, Chalky::Sidebar::MenuItem::Component

        attr_reader :title, :description, :icon_path, :icon_color_class, :css_classes, :spacing_classes

        ICON_COLORS = {
          blue: "bg-blue-100 text-blue-600",
          green: "bg-green-100 text-green-600",
          purple: "bg-purple-100 text-purple-600",
          orange: "bg-orange-100 text-orange-600",
          red: "bg-red-100 text-red-600",
          gray: "bg-gray-100 text-gray-600",
          indigo: "bg-indigo-100 text-indigo-600"
        }.freeze

        def initialize(title: nil, icon_path: nil, description: nil, icon_color: :blue, css_classes: "", spacing: "mb-6")
          super()
          @title = title
          @description = description
          @icon_path = icon_path
          @icon_color_class = ICON_COLORS[icon_color] || ICON_COLORS[:blue]
          @css_classes = css_classes
          @spacing_classes = spacing
        end

        def section_classes
          base_classes = "sidebar-section bg-white rounded-xl shadow-sm border border-gray-200 p-4 transition-shadow hover:shadow-md"
          [base_classes, spacing_classes, css_classes].compact.join(" ")
        end

        def header_classes
          "sidebar-section-header flex items-center gap-3 mb-3"
        end

        def icon_container_classes
          base_classes = "sidebar-section-icon flex-shrink-0 w-8 h-8 flex items-center justify-center rounded-lg"
          [base_classes, icon_color_class].compact.join(" ")
        end

        def show_header?
          title.present? && icon_path.present?
        end
      end
    end
  end
end
