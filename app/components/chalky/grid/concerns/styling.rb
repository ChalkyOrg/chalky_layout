# frozen_string_literal: true

module Chalky::Grid
  module Concerns
    # Module handling all styling and CSS classes for the Grid
    # Centralizes style definitions for easier maintenance
    module Styling
      extend ActiveSupport::Concern

      # Classes for table headers (th)
      def th_classes(_column = nil)
        "h-10 py-2 px-4 text-left text-xs font-semibold text-gray-600 whitespace-nowrap"
      end

      # Classes for table cells (td)
      def td_classes(_column = nil, _row_index = nil, _total_rows = nil)
        "py-2 px-4 text-sm text-gray-700 whitespace-nowrap"
      end

      # Classes for rows according to variant
      def row_classes(_row_index = nil, _total_rows = nil, row = nil)
        base_classes = Chalky::Grid::Component::VARIANTS[variant][:row]

        # Apply custom Proc if provided
        if row_classes_proc && row
          custom_classes = row_classes_proc.call(row)
          base_classes = "#{base_classes} #{custom_classes}".strip if custom_classes.present?
        end

        base_classes
      end

      # Classes for the main table with customization
      def table_classes
        base_classes = Chalky::Grid::Component::VARIANTS[variant][:table]
        [base_classes, css_classes].compact.join(" ")
      end

      # Classes for table header
      def header_classes
        Chalky::Grid::Component::VARIANTS[variant][:header]
      end

      # Specific classes for text cells
      def text_cell_classes
        "font-normal text-sm text-gray-700 whitespace-nowrap truncate max-w-xs"
      end
    end
  end
end
