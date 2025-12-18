# frozen_string_literal: true

module Chalky::Grid
  # Parameter object pattern for Grid::Component configuration options
  # Reduces parameter lists and centralizes default configuration
  class ComponentOptions
    DEFAULT_OPTIONS = {
      variant: :admin,
      details_path: nil,
      details_path_id_method: :id,
      row_count_key: nil,
      details_path_attributes: {},
      css_classes: "",
      responsive: true,
      bulk_selection: false,
      index_badge_proc: nil,
      pagy: nil
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

    def to_h
      @options
    end

    def variant
      @options[:variant]
    end

    def responsive?
      @options[:responsive]
    end

    def bulk_selection?
      @options[:bulk_selection]
    end
  end
end
