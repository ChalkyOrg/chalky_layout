# frozen_string_literal: true

module Chalky::Grid
  module Concerns
    # Module containing time-related columns
    # Temporal columns: datetime, date
    module DateTimeColumns
      extend ActiveSupport::Concern

      # Datetime column with formatting
      def datetime(label:, method:, **user_options)
        opts = Chalky::Grid::ColumnOptions.new(data_type: :datetime, formatted_as: :with_time, **user_options)
        add_column(label, method, opts) do |value|
          Chalky::Grid::Cell::Datetime::Component.new(
            data: get_nested_value(value, method),
            formatted_as: opts.formatted_as
          )
        end
      end

      # Simple date column
      def date(label:, method:, **user_options)
        opts = Chalky::Grid::ColumnOptions.new(data_type: :date, **user_options)
        add_column(label, method, opts) do |value|
          Chalky::Grid::Cell::Date::Component.new(
            data: get_nested_value(value, method),
            formatted_as: opts.formatted_as
          )
        end
      end
    end
  end
end
