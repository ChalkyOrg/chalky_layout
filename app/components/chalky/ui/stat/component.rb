# frozen_string_literal: true

module Chalky::Ui
  module Stat
    class Component < ViewComponent::Base
      ICON_COLORS = {
        gray: "bg-chalky-accent-gray",
        green: "bg-chalky-accent-green",
        red: "bg-chalky-accent-red",
        blue: "bg-chalky-accent-blue",
        yellow: "bg-chalky-accent-yellow",
        orange: "bg-chalky-accent-orange",
        purple: "bg-chalky-accent-purple"
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
          "text-chalky-success"
        when :down
          "text-chalky-danger"
        else
          "text-chalky-text-tertiary"
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
