# frozen_string_literal: true

require_relative "basic_columns"
require_relative "date_time_columns"
require_relative "association_columns"
require_relative "interactive_columns"

module Chalky::Grid
  module Concerns
    # Module containing all column definition methods
    # Organized into sub-modules by data type for better maintainability
    module ColumnDefinitions
      extend ActiveSupport::Concern

      include BasicColumns
      include DateTimeColumns
      include AssociationColumns
      include InteractiveColumns

      private

      # Helper method to add a column to the grid
      # Centralizes column creation logic
      def add_column(label, _method, options, &)
        component = proc(&)
        @columns << Chalky::Grid::Component::Column.new(label, component, **options.to_column_params)
      end
    end
  end
end
