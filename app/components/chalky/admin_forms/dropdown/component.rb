# frozen_string_literal: true

module Chalky::AdminForms
  module Dropdown
    class Component < ViewComponent::Base
      renders_many :items, Item::Component
      renders_one :trigger

      attr_reader :variant, :pop_direction, :css_classes, :data_attributes

      VARIANTS = {
        primary: {
          button: "text-gray-600 bg-white/50 border border-gray-200/60 hover:bg-gray-50 hover:text-gray-700 " \
                  "hover:border-gray-300 hover:shadow-sm focus:ring-2 focus:ring-blue-200 focus:border-blue-300 " \
                  "transition-all duration-200 ease-in-out hover:scale-105 active:scale-95",
          menu: "border-gray-200 bg-white shadow-lg",
          item: "text-gray-700 hover:bg-gray-50"
        },
        secondary: {
          button: "text-contrast bg-white/30 border border-contour/40 hover:bg-light hover:border-contour " \
                  "hover:shadow-sm focus:ring-2 focus:ring-contour/50 transition-all duration-200 " \
                  "ease-in-out hover:scale-105 active:scale-95",
          menu: "border-contour bg-white shadow-sm",
          item: "text-contrast hover:bg-light"
        },
        admin: {
          button: "text-gray-600 bg-gray-50/60 border border-gray-200/50 hover:bg-gray-100 " \
                  "hover:text-gray-700 hover:border-gray-300 hover:shadow-md focus:ring-2 " \
                  "focus:ring-gray-300 focus:border-gray-400 transition-all duration-200 " \
                  "ease-in-out hover:scale-105 active:scale-95",
          menu: "border-gray-200 bg-white shadow-lg ring-1 ring-black ring-opacity-5",
          item: "text-gray-700 hover:bg-gray-100"
        }
      }.freeze

      POP_DIRECTIONS = {
        right: "origin-top-right right-0",
        left: "origin-top-left left-0"
      }.freeze

      def initialize(variant: :admin, pop_direction: :right, css_classes: "", **data_attributes)
        super()
        @variant = variant.to_sym
        @pop_direction = pop_direction.to_sym
        @css_classes = css_classes
        @data_attributes = data_attributes
      end

      def button_classes
        base_classes = "h-full focus-visible:outline-none focus:outline-none cursor-pointer"
        variant_classes = VARIANTS[variant][:button]
        [base_classes, variant_classes, css_classes].compact.join(" ")
      end

      # Minimal classes for custom trigger wrapper - no styling, just functionality
      def trigger_wrapper_classes
        "focus-visible:outline-none focus:outline-none cursor-pointer"
      end

      def menu_classes
        base_classes = "dropdown-menu hidden absolute z-[9999] mt-2 max-w-72 divide-y divide-gray-200 rounded-md focus:outline-none"
        variant_classes = VARIANTS[variant][:menu]
        position_classes = POP_DIRECTIONS[pop_direction]
        [base_classes, variant_classes, position_classes].compact.join(" ")
      end

      def item_classes
        base_classes = "block px-4 py-2 text-sm whitespace-nowrap flex justify-start items-center"
        variant_classes = VARIANTS[variant][:item]
        [base_classes, variant_classes].compact.join(" ")
      end

      def container_classes
        "relative inline-block"
      end

      def dropdown_data
        { controller: "dropdown" }.merge(data_attributes)
      end
    end
  end
end
