# frozen_string_literal: true

module Chalky::AdminForms
  module Button
    class Component < ViewComponent::Base
      attr_reader :variant, :size, :icon_path, :css_classes, :html_options

      VARIANTS = {
        primary: "bg-blue-600 hover:bg-blue-700 focus:ring-blue-200 text-white",
        secondary: "bg-gray-100 hover:bg-gray-200 focus:ring-gray-200 text-gray-700",
        success: "bg-green-600 hover:bg-green-700 focus:ring-green-200 text-white",
        danger: "bg-red-600 hover:bg-red-700 focus:ring-red-200 text-white"
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
