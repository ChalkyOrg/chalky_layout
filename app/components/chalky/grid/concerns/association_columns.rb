# frozen_string_literal: true

module Chalky::Grid
  module Concerns
    # Module containing association-related columns
    # Associative columns: references, users, lookups
    module AssociationColumns
      extend ActiveSupport::Concern

      # References/associations column
      def references(label:, method:, **user_options)
        opts = Chalky::Grid::ColumnOptions.new(data_type: :references, **user_options)
        add_column(label, method, opts) do |value|
          Chalky::Grid::Cell::References::Component.new(
            data: get_nested_value(value, method),
            formatted_as: opts.formatted_as
          )
        end
      end

      # Users column
      def users(label:, method:, **user_options)
        opts = Chalky::Grid::ColumnOptions.new(data_type: :users, **user_options)
        add_column(label, method, opts) do |value|
          Chalky::Grid::Cell::Users::Component.new(data: get_nested_value(value, method))
        end
      end

      # Lookups column
      def lookups(label:, method:, **user_options)
        opts = Chalky::Grid::ColumnOptions.new(data_type: :lookups, **user_options)
        add_column(label, method, opts) do |value|
          Chalky::Grid::Cell::Lookups::Component.new(data: get_nested_value(value, method))
        end
      end
    end
  end
end
