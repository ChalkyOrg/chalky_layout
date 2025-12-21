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
          blue: "bg-chalky-accent-blue-light text-chalky-accent-blue",
          green: "bg-chalky-accent-green-light text-chalky-accent-green",
          purple: "bg-chalky-accent-purple-light text-chalky-accent-purple",
          orange: "bg-chalky-accent-orange-light text-chalky-accent-orange",
          red: "bg-chalky-accent-red-light text-chalky-accent-red",
          gray: "bg-chalky-accent-gray-light text-chalky-accent-gray",
          indigo: "bg-chalky-accent-indigo-light text-chalky-accent-indigo"
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
          base_classes = "sidebar-section bg-chalky-surface rounded-xl shadow-sm border border-chalky-border p-4 transition-shadow hover:shadow-md"
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
