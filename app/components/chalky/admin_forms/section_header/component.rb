# frozen_string_literal: true

module Chalky::AdminForms
  module SectionHeader
    class Component < ViewComponent::Base
      attr_reader :title, :description, :icon_path, :icon_color_class, :spacing_classes

      ICON_COLORS = {
        blue: "bg-chalky-accent-blue-light text-chalky-accent-blue",
        green: "bg-chalky-accent-green-light text-chalky-accent-green",
        purple: "bg-chalky-accent-purple-light text-chalky-accent-purple",
        orange: "bg-chalky-accent-orange-light text-chalky-accent-orange",
        red: "bg-chalky-accent-red-light text-chalky-accent-red",
        gray: "bg-chalky-accent-gray-light text-chalky-accent-gray"
      }.freeze

      def initialize(title:, description: nil, icon_path: nil, icon_color: :blue, spacing: "mb-6")
        super()
        @title = title
        @description = description
        @icon_path = icon_path
        @icon_color_class = ICON_COLORS[icon_color] || ICON_COLORS[:blue]
        @spacing_classes = spacing
      end

      def header_classes
        base_classes = "flex items-center"
        [base_classes, spacing_classes].compact.join(" ")
      end

      def icon_container_classes
        base_classes = "w-10 h-10 rounded-lg flex items-center justify-center mr-4"
        [base_classes, icon_color_class].compact.join(" ")
      end

      def show_icon?
        icon_path.present?
      end

      # Detect if icon_path is a Font Awesome class (fa-*) or a SVG path
      def font_awesome_icon?
        icon_path.present? && icon_path.to_s.start_with?("fa-")
      end
    end
  end
end
