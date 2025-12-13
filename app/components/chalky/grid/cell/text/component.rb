# frozen_string_literal: true

module Chalky::Grid
  module Cell
    module Text
      class Component < Chalky::ApplicationComponent
        attr_reader :data

        def initialize(data:)
          super()
          @data = data
        end

        def render?
          data.present?
        end
      end
    end
  end
end
