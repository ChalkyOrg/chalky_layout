# frozen_string_literal: true

module Chalky::Grid
  class Component < Chalky::ApplicationComponent
    include ActiveSupport::Inflector
    include Chalky::Grid::Concerns::ColumnDefinitions
    include Chalky::Grid::Concerns::ResponsiveBehavior
    include Chalky::Grid::Concerns::Styling

    attr_reader :columns, :rows, :details_path, :details_path_id_method, :row_count_key, :details_path_attributes, :variant, :css_classes, :bulk_selection,
                :row_data_attributes, :row_classes_proc, :index_badge_proc

    VARIANTS = {
      default: {
        table: "bg-white rounded-xl shadow-sm min-w-full",
        header: "bg-gray-50 border-b border-gray-200",
        row: "hover:bg-gray-50 group transition-colors duration-150 border-b border-gray-200 last:border-b-0"
      },
      simple: {
        table: "min-w-full border-collapse",
        header: "bg-gray-100 border-b border-gray-200",
        row: "hover:bg-gray-50 group transition-colors duration-150 border-b border-gray-200 last:border-b-0"
      },
      admin: {
        table: "bg-white rounded-xl shadow-sm min-w-full",
        header: "bg-gray-100 border-b border-gray-200",
        row: "hover:bg-gray-50 group transition-colors duration-150"
      }
    }.freeze

    def actions
      @actions ||= []
    end

    def initialize(rows:, horizontal_scroll: nil, row_data_attributes: nil, row_classes_proc: nil, index_badge_proc: nil, **)
      super()
      component_opts = Chalky::Grid::ComponentOptions.new(**)

      @rows = rows
      @variant = component_opts.variant.to_sym
      @details_path = component_opts.details_path
      @details_path_id_method = component_opts.details_path_id_method
      @row_count_key = component_opts.row_count_key
      @details_path_attributes = component_opts.details_path_attributes
      @css_classes = component_opts.css_classes
      @responsive = component_opts.responsive
      @bulk_selection = component_opts.bulk_selection
      @horizontal_scroll = horizontal_scroll
      @row_data_attributes = row_data_attributes
      @row_classes_proc = row_classes_proc
      @index_badge_proc = index_badge_proc || component_opts.index_badge_proc
      @columns = []
      @actions = []
    end

    # Action method to define row actions
    def action(name:, path:, icon:, data: {}, options: {})
      @actions << Action.new(name, path, icon, data, options)
    end

    # Helper method to handle nested attribute access like "user.full_name"
    def get_nested_value(object, method_string)
      # If it's a Proc/lambda, call it directly
      return method_string.call(object) if method_string.respond_to?(:call)

      # Otherwise, treat as a string/symbol for nested access
      method_string.to_s.split(".").reduce(object) do |current_object, method_name|
        return nil if current_object.nil?

        current_object.send(method_name)
      end
    rescue NoMethodError
      nil
    end

    # Method to get data attributes for a row
    def row_data_attributes_for(row)
      return {} unless row_data_attributes.is_a?(Proc)

      row_data_attributes.call(row) || {}
    rescue StandardError
      {}
    end

    # Method to get index badge classes for a row
    def index_badge_classes_for(row)
      return nil unless index_badge_proc.is_a?(Proc)

      index_badge_proc.call(row)
    rescue StandardError
      nil
    end

    private

    # By calling content, we ensure that the view component calls the block, and @columns get populated
    def before_render
      content
    end

    def link_cell?(column)
      %i[link users].include?(column.data_type)
    end

    class Column
      attr_reader :label, :component, :data_type, :priority, :responsive

      PRIORITY_LEVELS = %i[primary secondary optional].freeze

      def initialize(label, component, data_type: nil, priority: :secondary, responsive: {})
        @label = label
        @component = component
        @data_type = data_type
        @priority = PRIORITY_LEVELS.include?(priority.to_sym) ? priority.to_sym : :secondary
        @responsive = responsive
      end

      def visible_on?(breakpoint)
        case priority
        when :secondary
          %i[tablet desktop].include?(breakpoint)
        when :optional
          breakpoint == :desktop
        else # :primary or any other value
          true
        end
      end
    end

    class Action
      attr_reader :name, :path, :icon, :data, :id_param_key, :id_method, :unless_option, :classes, :variant

      def initialize(name, path, icon, data, options = {})
        @name = name
        @path = path
        @icon = icon
        @data = data
        @id_param_key = options[:id_param_key] || :id
        @id_method = options[:id_method] || :id
        @unless_option = options[:unless]
        @classes = options[:classes]
        @variant = options[:variant] || :admin
      end
    end
  end
end
