# frozen_string_literal: true

module Chalky::Grid
  module Cell
    module Link
      class Component < Chalky::ApplicationComponent
        attr_reader :data, :path

        def initialize(data:, path:)
          super()
          @data = data
          @path = path
        end

        def render?
          data.present? && path.present?
        end
      end
    end
  end
end
