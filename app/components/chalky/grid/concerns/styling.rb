# frozen_string_literal: true

module Chalky::Grid
  module Concerns
    # Module handling all styling and CSS classes for the Grid
    # Centralizes style definitions for easier maintenance
    module Styling
      extend ActiveSupport::Concern

      # Classes for table headers (th)
      def th_classes(column = nil)
        base_classes = "py-3 px-4 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
        if column.respond_to?(:priority) && column.priority == :primary
          "#{base_classes} border-b border-gray-200"
        else
          base_classes
        end
      end

      # Classes for table cells (td)
      def td_classes(column = nil, row_index = nil, total_rows = nil)
        base_classes = "py-4 px-4 text-sm text-gray-700"
        border_classes = []

        # For primary columns: special logic with horizontal borders
        if column.respond_to?(:priority) && column.priority == :primary
          border_classes << "border-t" unless row_index == 1
          border_classes << "border-b" unless row_index == total_rows
          border_classes << "border-gray-200" if border_classes.any?
        end

        # For ALL columns: remove border-bottom on the last row
        if row_index == total_rows
          border_classes << "!border-b-0"
        end

        "#{base_classes} #{border_classes.join(' ')}"
      end

      # Classes for rows according to variant
      def row_classes(row_index = nil, total_rows = nil, row = nil)
        base_classes = Grid::Component::VARIANTS[variant][:row]

        # For the last row, remove all border-bottom
        if row_index == total_rows
          base_classes = base_classes.gsub(/border-b(\s+border-gray-\d+)?/, "").
            gsub("last:border-b-0", "").
            gsub(/\s+/, " ").
            strip
        end

        # Apply custom Proc if provided
        if row_classes_proc && row
          custom_classes = row_classes_proc.call(row)
          base_classes = "#{base_classes} #{custom_classes}".strip if custom_classes.present?
        end

        base_classes
      end

      # Classes for the main table with customization
      def table_classes
        base_classes = Grid::Component::VARIANTS[variant][:table]
        [base_classes, css_classes].compact.join(" ")
      end

      # Classes for table header
      def header_classes
        Grid::Component::VARIANTS[variant][:header]
      end

      # Specific classes for text cells
      def text_cell_classes
        "font-normal text-sm text-gray-700"
      end
    end
  end
end
