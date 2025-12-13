# frozen_string_literal: true

module Chalky::Grid
  module Cell
    module Boolean
      class Component < Chalky::ApplicationComponent
        attr_reader :data

        def initialize(data:)
          super()
          @data = data
        end

        def icon_classes
          if data
            "fas fa-check-circle text-green-500"
          else
            "fas fa-times-circle text-gray-300"
          end
        end
      end
    end
  end
end
