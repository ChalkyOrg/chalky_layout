# frozen_string_literal: true

module Chalky::Ui
  module Tooltip
    class Component < ViewComponent::Base
      attr_reader :text, :position, :variant, :delay

      POSITIONS = %i[top bottom left right].freeze
      VARIANTS = %i[dark light].freeze

      def initialize(text:, position: :top, variant: :dark, delay: 0)
        super()
        @text = text
        @position = POSITIONS.include?(position.to_sym) ? position.to_sym : :top
        @variant = VARIANTS.include?(variant.to_sym) ? variant.to_sym : :dark
        @delay = delay
      end

      def tooltip_classes
        base = "absolute z-50 px-3 py-2 text-sm font-medium rounded-lg shadow-lg whitespace-nowrap pointer-events-none transition-all duration-200"

        variant_classes = case variant
                          when :light
                            "bg-white text-gray-900 border border-gray-200"
                          else
                            "bg-gray-900 text-white"
                          end

        position_classes = case position
                           when :top
                             "bottom-full left-1/2 -translate-x-1/2 mb-2"
                           when :bottom
                             "top-full left-1/2 -translate-x-1/2 mt-2"
                           when :left
                             "right-full top-1/2 -translate-y-1/2 mr-2"
                           when :right
                             "left-full top-1/2 -translate-y-1/2 ml-2"
                           end

        "#{base} #{variant_classes} #{position_classes}"
      end

      def arrow_classes
        base = "absolute w-2 h-2 rotate-45"

        variant_classes = case variant
                          when :light
                            "bg-white border-gray-200"
                          else
                            "bg-gray-900"
                          end

        position_classes = case position
                           when :top
                             "-bottom-1 left-1/2 -translate-x-1/2 #{variant == :light ? 'border-b border-r' : ''}"
                           when :bottom
                             "-top-1 left-1/2 -translate-x-1/2 #{variant == :light ? 'border-t border-l' : ''}"
                           when :left
                             "-right-1 top-1/2 -translate-y-1/2 #{variant == :light ? 'border-t border-r' : ''}"
                           when :right
                             "-left-1 top-1/2 -translate-y-1/2 #{variant == :light ? 'border-b border-l' : ''}"
                           end

        "#{base} #{variant_classes} #{position_classes}"
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
