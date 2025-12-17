# frozen_string_literal: true

module Chalky
  module Grid
    module Cell
      module Image
        class Component < Chalky::Component
          attr_reader :data, :size

          def initialize(data:, size: :small)
            super()
            @data = data
            @size = size.to_sym
          end

          private

          def render?
            data.present?
          end

          def image_classes
            case size
            when :medium
              "w-16 h-16 rounded-lg object-cover"
            when :large
              "w-20 h-20 rounded-lg object-cover"
            else # :small or any other value
              "w-10 h-10 rounded-md object-cover"
            end
          end

          def variant_options
            case size
            when :medium
              { resize_to_fill: [64, 64] }
            when :large
              { resize_to_fill: [80, 80] }
            else # :small or any other value
              { resize_to_fill: [40, 40] }
            end
          end
        end
      end
    end
  end
end
