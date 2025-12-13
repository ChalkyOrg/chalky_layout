# frozen_string_literal: true

module Chalky::Grid
  module Cell
    module Icon
      class Component < Chalky::ApplicationComponent
        attr_reader :display, :icon

        def initialize(display:, icon:)
          super()
          @display = display
          @icon = icon
        end

        def render?
          display
        end
      end
    end
  end
end
