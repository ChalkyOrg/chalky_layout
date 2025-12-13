# frozen_string_literal: true

module Chalky::Grid
  module Concerns
    # Module containing interactive and complex columns
    # Interactive columns: select, formula, modal_data, link, project_files, price_range, status_icon
    module InteractiveColumns
      extend ActiveSupport::Concern

      # Select/dropdown column
      def select(label:, method:, **user_options)
        opts = Chalky::Grid::ColumnOptions.new(data_type: :select, **user_options)
        options = if opts.data_type == :enumerize
                    {
                      model_name: @rows.first && @rows.first.class.name.underscore,
                      attribute: method
                    }
                  else
                    {}
                  end

        add_column(label, method, opts) do |value|
          Chalky::Grid::Cell::Select::Component.new(
            data: get_nested_value(value, method),
            formatted_as: opts.data_type,
            options:
          )
        end
      end

      # Calculated formula column
      def formula(label:, method:, **user_options)
        opts = Chalky::Grid::ColumnOptions.new(data_type: :formula, **user_options)
        add_column(label, method, opts) do |value|
          Chalky::Grid::Cell::Formula::Component.new(data: get_nested_value(value, method))
        end
      end

      # Modal data column with dynamic path
      def modal_data(label:, method:, path:, **user_options)
        opts = Chalky::Grid::ColumnOptions.new(data_type: :users, **user_options)
        add_column(label, method, opts) do |value|
          Chalky::Grid::Cell::ModalData::Component.new(
            data: get_nested_value(value, method),
            path: public_send(path, value)
          )
        end
      end

      # Link column with dynamic path
      def link(label:, method:, path:, **user_options)
        opts = Chalky::Grid::ColumnOptions.new(data_type: :link, priority: :primary, **user_options)
        add_column(label, method, opts) do |value|
          Chalky::Grid::Cell::Link::Component.new(
            data: get_nested_value(value, method),
            path: public_send(path, value)
          )
        end
      end

      # Project files column
      def project_files(label:, method:, **user_options)
        opts = Chalky::Grid::ColumnOptions.new(data_type: :project_files, **user_options)
        add_column(label, method, opts) do |value|
          Chalky::Grid::Cell::ProjectFiles::Component.new(data: get_nested_value(value, method))
        end
      end

      # Special price range column
      def price_range(label:, method: nil, **user_options)
        _ = method # method parameter kept for consistency with other column methods
        opts = Chalky::Grid::ColumnOptions.new(data_type: :price_range, **user_options)
        add_column(label, method, opts) do |value|
          Chalky::Grid::Cell::PriceRange::Component.new(data: value)
        end
      end

      # Status icon column
      def status_icon(label:, method: :status, **user_options)
        _ = method # method parameter kept for consistency with other column methods
        opts = Chalky::Grid::ColumnOptions.new(data_type: :status_icon, **user_options)
        add_column(label, method, opts) do |value|
          Chalky::Grid::Cell::StatusIcon::Component.new(data: value)
        end
      end

      # Stock management column with + and - buttons
      def stock_management(label:, method: :stock, **user_options)
        _ = method # method parameter kept for consistency with other column methods
        opts = Chalky::Grid::ColumnOptions.new(data_type: :stock_management, priority: :secondary, **user_options)
        add_column(label, method, opts) do |item|
          Chalky::Grid::Cell::StockManagement::Component.new(item:)
        end
      end
    end
  end
end
