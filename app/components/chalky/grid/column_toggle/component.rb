# frozen_string_literal: true

module Chalky::Grid
  module ColumnToggle
    class Component < ViewComponent::Base
      attr_reader :columns

      def initialize(columns:)
        super()
        @columns = columns
      end
    end
  end
end
