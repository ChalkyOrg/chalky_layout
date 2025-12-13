# frozen_string_literal: true

module Chalky::Grid
  module Cell
    module Badge
      class Component < Chalky::ApplicationComponent
        attr_reader :data, :color

        def initialize(data:, color:)
          super()
          @color = color
          @data = data
        end

        def render?
          data.present?
        end

        private

        def badge_classes
          base_classes = "inline-flex items-center rounded-full px-2 py-1 text-xs font-medium whitespace-nowrap"
          color_classes = case color.to_sym
                          when :green
                            "bg-green-100 text-green-800"
                          when :red
                            "bg-red-100 text-red-800"
                          when :blue
                            "bg-blue-100 text-blue-800"
                          when :yellow
                            "bg-yellow-100 text-yellow-800"
                          when :purple
                            "bg-purple-100 text-purple-800"
                          when :orange
                            "bg-orange-100 text-orange-800"
                          else
                            "bg-gray-100 text-gray-800"
                          end
          "#{base_classes} #{color_classes}"
        end
      end
    end
  end
end
