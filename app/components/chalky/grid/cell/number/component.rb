# frozen_string_literal: true

module Chalky::Grid
  module Cell
    module Number
      class Component < Chalky::ApplicationComponent
        attr_reader :data, :unit

        def initialize(data:, unit: nil)
          super()
          @data = data
          @unit = unit
        end

        def render?
          data.present?
        end

        def formatted_number
          formatted = number_with_delimiter(data)
          unit ? "#{formatted} #{unit}" : formatted
        end
      end
    end
  end
end
