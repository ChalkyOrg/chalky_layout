# frozen_string_literal: true

module Chalky::Grid
  # Parameter object pattern for column options
  # Reduces parameter lists and improves maintainability
  class ColumnOptions
    DEFAULT_OPTIONS = {
      data_type: :text,
      priority: :secondary,
      responsive: {},
      formatted_as: :default,
      size: :small,
      color: :green,
      unit: nil,
      tooltip: nil
    }.freeze

    attr_reader :options

    def initialize(**user_options)
      @options = DEFAULT_OPTIONS.merge(user_options)
    end

    def method_missing(method_name, *args)
      return @options[method_name] if @options.key?(method_name)

      super
    end

    def respond_to_missing?(method_name, include_private = false)
      @options.key?(method_name) || super
    end

    # Returns only the parameters needed for Column.new
    def to_column_params
      @options.slice(:data_type, :priority, :responsive)
    end

    def to_h
      @options
    end
  end
end
