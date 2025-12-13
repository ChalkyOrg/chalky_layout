# frozen_string_literal: true

module Chalky::Ui
  module Stat
    class Component < ViewComponent::Base
      ICON_COLORS = {
        gray: "bg-gray-500",
        green: "bg-green-500",
        red: "bg-red-500",
        blue: "bg-blue-500",
        yellow: "bg-yellow-500",
        orange: "bg-orange-500",
        purple: "bg-purple-500"
      }.freeze

      attr_reader :label, :value, :icon, :icon_color, :subtitle, :trend

      def initialize(label:, value:, icon: nil, icon_color: :blue, subtitle: nil, trend: nil)
        super()
        @label = label
        @value = value
        @icon = icon
        @icon_color = icon_color.to_sym
        @subtitle = subtitle
        @trend = trend # :up, :down, or nil
      end

      def icon_container_classes
        [
          "flex-shrink-0 w-10 h-10 rounded-lg flex items-center justify-center",
          ICON_COLORS.fetch(icon_color, ICON_COLORS[:blue])
        ].join(" ")
      end

      def trend_classes
        case trend
        when :up
          "text-green-600"
        when :down
          "text-red-600"
        else
          "text-gray-500"
        end
      end

      def trend_icon
        case trend
        when :up
          "fa-solid fa-arrow-up"
        when :down
          "fa-solid fa-arrow-down"
        end
      end
    end
  end
end
