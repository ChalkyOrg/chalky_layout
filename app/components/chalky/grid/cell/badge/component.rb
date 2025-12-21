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
                            "bg-chalky-accent-green-light text-chalky-accent-green-text"
                          when :red
                            "bg-chalky-accent-red-light text-chalky-accent-red-text"
                          when :blue
                            "bg-chalky-accent-blue-light text-chalky-accent-blue-text"
                          when :yellow
                            "bg-chalky-accent-yellow-light text-chalky-accent-yellow-text"
                          when :purple
                            "bg-chalky-accent-purple-light text-chalky-accent-purple-text"
                          when :orange
                            "bg-chalky-accent-orange-light text-chalky-accent-orange-text"
                          else
                            "bg-chalky-accent-gray-light text-chalky-accent-gray-text"
                          end
          "#{base_classes} #{color_classes}"
        end
      end
    end
  end
end
