# frozen_string_literal: true

module Chalky::Grid
  module Concerns
    # Module containing basic display columns
    # Simple columns: text, badge, number, icon, image
    module BasicColumns
      extend ActiveSupport::Concern

      # Simple text column (main method)
      def text(label:, method:, **user_options)
        opts = Chalky::Grid::ColumnOptions.new(priority: :primary, **user_options)
        add_column(label, method, opts) do |value|
          Chalky::Grid::Cell::Text::Component.new(data: get_nested_value(value, method))
        end
      end

      # Colored badge column
      def badge(label:, method:, **user_options)
        opts = Chalky::Grid::ColumnOptions.new(data_type: :text, color: :green, **user_options)
        add_column(label, method, opts) do |value|
          Chalky::Grid::Cell::Badge::Component.new(
            data: get_nested_value(value, method),
            color: opts.color
          )
        end
      end

      # Boolean column (yes/no indicator)
      def boolean(label:, method:, **user_options)
        opts = Chalky::Grid::ColumnOptions.new(data_type: :boolean, **user_options)
        add_column(label, method, opts) do |value|
          Chalky::Grid::Cell::Boolean::Component.new(data: get_nested_value(value, method))
        end
      end

      # Numeric column with unit
      def number(label:, method:, **user_options)
        opts = Chalky::Grid::ColumnOptions.new(data_type: :number, **user_options)
        add_column(label, method, opts) do |value|
          Chalky::Grid::Cell::Number::Component.new(
            data: get_nested_value(value, method),
            unit: opts.unit
          )
        end
      end

      # Simple icon column
      def icon(method:, icon:, **user_options)
        opts = Chalky::Grid::ColumnOptions.new(priority: :primary, **user_options)
        add_column(nil, method, opts) do |value|
          Chalky::Grid::Cell::Icon::Component.new(
            display: get_nested_value(value, method),
            icon:
          )
        end
      end

      # Image column with sizes
      def image(label:, method:, **user_options)
        opts = Chalky::Grid::ColumnOptions.new(data_type: :image, size: :small, **user_options)
        add_column(label, method, opts) do |value|
          Chalky::Grid::Cell::Image::Component.new(
            data: get_nested_value(value, method),
            size: opts.size
          )
        end
      end

      # Custom column with personalized content
      def custom(label:, **user_options, &block)
        opts = Chalky::Grid::ColumnOptions.new(priority: :primary, **user_options)
        add_column(label, nil, opts) do |value|
          # Capture the HTML content by calling the block in the view context
          html_content = helpers.capture(value, &block)
          Chalky::Grid::Cell::Custom::Component.new(html_content:)
        end
      end
    end
  end
end
