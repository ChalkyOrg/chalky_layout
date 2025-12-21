# frozen_string_literal: true

module Chalky::AdminForms
  module Button
    class Component < ViewComponent::Base
      attr_reader :variant, :size, :icon_path, :css_classes, :html_options

      VARIANTS = {
        primary: "bg-chalky-primary hover:bg-chalky-primary-hover focus:ring-chalky-primary-light text-chalky-text-inverted",
        secondary: "bg-chalky-surface-tertiary hover:bg-chalky-surface-active focus:ring-chalky-surface-active text-chalky-text-secondary",
        success: "bg-chalky-success hover:bg-chalky-success-hover focus:ring-chalky-success-light text-chalky-text-inverted",
        danger: "bg-chalky-danger hover:bg-chalky-danger-hover focus:ring-chalky-danger-light text-chalky-text-inverted"
      }.freeze

      SIZES = {
        sm: "px-4 py-2 text-sm",
        md: "px-6 py-3",
        lg: "px-8 py-3"
      }.freeze

      def initialize(variant: :primary, size: :md, icon_path: nil, css_classes: "", **html_options)
        super()
        @variant = variant.to_sym
        @size = size.to_sym
        @icon_path = icon_path
        @css_classes = css_classes
        @html_options = html_options
      end

      def button_classes
        base_classes = "inline-flex items-center font-medium rounded-lg shadow-sm " \
                       "transition-all duration-200 focus:ring-4 focus:outline-none"
        variant_classes = VARIANTS[variant] || VARIANTS[:primary]
        size_classes = SIZES[size] || SIZES[:md]

        [base_classes, variant_classes, size_classes, css_classes].compact.join(" ")
      end

      def show_icon?
        icon_path.present?
      end

      def button_type
        html_options[:type] || "button"
      end

      def button_data
        html_options[:data] || {}
      end
    end
  end
end
