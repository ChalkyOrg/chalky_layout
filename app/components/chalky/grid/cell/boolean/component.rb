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
            "fas fa-check-circle text-chalky-success"
          else
            "fas fa-times-circle text-chalky-text-muted"
          end
        end
      end
    end
  end
end
