# frozen_string_literal: true

module Chalky::Ui
  module Badge
    class Component < ViewComponent::Base
      COLORS = {
        gray: "bg-chalky-accent-gray-light text-chalky-accent-gray-text",
        green: "bg-chalky-accent-green-light text-chalky-accent-green-text",
        red: "bg-chalky-accent-red-light text-chalky-accent-red-text",
        blue: "bg-chalky-accent-blue-light text-chalky-accent-blue-text",
        yellow: "bg-chalky-accent-yellow-light text-chalky-accent-yellow-text",
        orange: "bg-chalky-accent-orange-light text-chalky-accent-orange-text",
        purple: "bg-chalky-accent-purple-light text-chalky-accent-purple-text"
      }.freeze

      SIZES = {
        xs: "px-1.5 py-0.5 text-xs",
        sm: "px-2 py-0.5 text-xs",
        md: "px-2.5 py-1 text-sm"
      }.freeze

      STYLES = {
        rounded: "rounded",
        pill: "rounded-full"
      }.freeze

      attr_reader :label, :color, :size, :style, :icon

      def initialize(label:, color: :gray, size: :sm, style: :rounded, icon: nil)
        super()
        @label = label
        @color = color.to_sym
        @size = size.to_sym
        @style = style.to_sym
        @icon = icon
      end

      def badge_classes
        [
          "inline-flex items-center font-medium",
          COLORS.fetch(color, COLORS[:gray]),
          SIZES.fetch(size, SIZES[:sm]),
          STYLES.fetch(style, STYLES[:rounded])
        ].join(" ")
      end
    end
  end
end
