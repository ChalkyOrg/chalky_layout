# frozen_string_literal: true

module Chalky::Grid
  module Concerns
    # Module handling all responsive behavior of the Grid
    # Includes desktop/mobile logic, breakpoints, and adaptive layouts
    module ResponsiveBehavior
      extend ActiveSupport::Concern

      # Responsive state methods
      def responsive?
        @responsive
      end

      def show_cards_layout?
        responsive? && !rows.empty?
      end

      def show_table_layout?
        !rows.empty? # Only show table if there are rows
      end

      def should_show_empty_state?
        rows.empty?
      end

      # Main container configuration
      def container_classes
        base_classes = responsive? ? "grid-responsive" : "grid-container"
        bulk_classes = bulk_selection ? "bulk-enabled" : ""
        scroll_classes = "grid-horizontal-scroll"
        [
          (responsive? ? base_classes.to_s : "scrollbox #{base_classes}"),
          bulk_classes,
          scroll_classes,
          css_classes
        ].compact.join(" ").strip
      end

      def container_data_attributes
        controllers = []
        controllers << "grid" if responsive?
        controllers << "grid-scroll"

        data_attrs = controllers.any? ? { controller: controllers.join(" ") } : {}
        data_attrs[:grid_columns_count] = total_columns_count
        data_attrs
      end

      # Intelligent detection of many columns
      def many_columns?
        return true if @horizontal_scroll == true

        count = total_columns_count
        count >= 4
      end

      def total_columns_count
        base_count = columns.size
        base_count += 1 if bulk_selection  # Checkbox column
        base_count += 1 if actions.any?    # Actions column
        base_count += 1                    # Index column
        base_count
      end

      # Data for mobile cards
      def mobile_card_data(row)
        columns.map do |column|
          {
            label: column.label,
            value: column.component.call(row),
            data_type: column.data_type,
            priority: column.respond_to?(:priority) ? column.priority : :secondary
          }
        end
      end

      # Filter columns by priority
      def primary_columns
        columns.select { |col| col.respond_to?(:priority) && col.priority == :primary }
      end

      def secondary_columns
        columns.select { |col| !col.respond_to?(:priority) || col.priority != :primary }
      end

      # Responsive CSS classes for headers (th)
      def responsive_th_classes(column)
        base_classes = th_classes
        responsive_classes = case column.respond_to?(:priority) ? column.priority : :secondary
                             when :primary
                               "lg:table-cell"
                             when :secondary
                               "hidden lg:table-cell"
                             when :optional
                               "hidden xl:table-cell"
                             else
                               ""
                             end
        "#{base_classes} #{responsive_classes}".strip
      end

      # Responsive CSS classes for cells (td)
      def responsive_td_classes(column)
        base_classes = td_classes
        responsive_classes = case column.respond_to?(:priority) ? column.priority : :secondary
                             when :primary
                               "lg:table-cell"
                             when :secondary
                               "hidden lg:table-cell"
                             when :optional
                               "hidden xl:table-cell"
                             else
                               ""
                             end
        "#{base_classes} #{responsive_classes}".strip
      end
    end
  end
end
