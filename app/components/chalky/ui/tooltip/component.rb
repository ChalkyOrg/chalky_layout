# frozen_string_literal: true

module Chalky::Ui
  module Tooltip
    class Component < ViewComponent::Base
      renders_one :trigger
      renders_one :tooltip_content

      attr_reader :position, :variant, :delay

      POSITIONS = %i[top bottom left right].freeze
      VARIANTS = %i[dark light].freeze

      def initialize(position: :top, variant: :dark, delay: 0)
        super()
        @position = POSITIONS.include?(position.to_sym) ? position.to_sym : :top
        @variant = VARIANTS.include?(variant.to_sym) ? variant.to_sym : :dark
        @delay = delay
      end

      def render?
        trigger? && tooltip_content?
      end

      def tooltip_wrapper_classes
        "z-50 pointer-events-none transition-all duration-200"
      end

      def tooltip_classes
        # Base classes for the tooltip body (text container)
        # max-w-xs (~320px) allows rich content while keeping tooltips reasonable
        base = "px-3 py-2 text-sm font-medium rounded-lg shadow-lg max-w-xs"

        variant_classes = case variant
                          when :light
                            "bg-chalky-surface text-chalky-text-primary border border-chalky-border"
                          else
                            "bg-chalky-tooltip-bg text-chalky-tooltip-text"
                          end

        "#{base} #{variant_classes}"
      end

      def arrow_classes
        # Base classes - positioning and rotation handled by JavaScript
        # -z-10 places arrow behind tooltip content so only the tip is visible
        base = "absolute w-2 h-2 -z-10"

        variant_classes = case variant
                          when :light
                            "bg-chalky-surface border border-chalky-border"
                          else
                            "bg-chalky-tooltip-bg"
                          end

        "#{base} #{variant_classes}"
      end

      def container_data
        {
          controller: "tooltip",
          tooltip_delay_value: delay,
          tooltip_position_value: position.to_s
        }
      end
    end
  end
end
