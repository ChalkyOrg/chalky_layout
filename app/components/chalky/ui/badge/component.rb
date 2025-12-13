# frozen_string_literal: true

module Chalky::Ui
  module Badge
    class Component < ViewComponent::Base
      COLORS = {
        gray: "bg-gray-100 text-gray-700",
        green: "bg-green-100 text-green-700",
        red: "bg-red-100 text-red-700",
        blue: "bg-blue-100 text-blue-700",
        yellow: "bg-yellow-100 text-yellow-700",
        orange: "bg-orange-100 text-orange-700",
        purple: "bg-purple-100 text-purple-700"
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
