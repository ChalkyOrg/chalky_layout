# frozen_string_literal: true

module Chalky::Ui
  module InfoRow
    class Component < ViewComponent::Base
      ICON_COLORS = {
        gray: "bg-chalky-accent-gray",
        green: "bg-chalky-accent-green",
        red: "bg-chalky-accent-red",
        blue: "bg-chalky-accent-blue",
        yellow: "bg-chalky-accent-yellow",
        orange: "bg-chalky-accent-orange",
        purple: "bg-chalky-accent-purple"
      }.freeze

      MAX_WIDTHS = {
        sm: "max-w-xs",
        md: "max-w-sm",
        lg: "max-w-md",
        xl: "max-w-lg"
      }.freeze

      attr_reader :label, :value, :separator, :bold_value,
                  :icon, :icon_color, :max_width, :href, :target, :copyable

      def initialize(
        label:,
        value: nil,
        separator: false,
        bold_value: false,
        icon: nil,
        icon_color: :gray,
        max_width: nil,
        href: nil,
        target: nil,
        copyable: false
      )
        super()
        @label = label
        @value = value
        @separator = separator
        @bold_value = bold_value
        @icon = icon
        @icon_color = icon_color.to_sym
        @max_width = max_width&.to_sym
        @href = href
        @target = target
        @copyable = copyable
      end

      def container_classes
        classes = []
        classes << MAX_WIDTHS[max_width] if max_width && MAX_WIDTHS[max_width]
        classes << "pt-3 mt-3 border-t border-chalky-border" if separator
        classes.join(" ")
      end

      def icon_container_classes
        [
          "flex-shrink-0 w-8 h-8 rounded-lg flex items-center justify-center",
          ICON_COLORS.fetch(icon_color, ICON_COLORS[:gray])
        ].join(" ")
      end

      def label_classes
        "text-sm font-medium text-chalky-text-tertiary"
      end

      def value_classes
        base = "text-sm text-chalky-text-primary"
        bold_value ? "#{base} font-semibold" : base
      end

      def link_classes
        "text-chalky-primary hover:text-chalky-primary-hover hover:underline"
      end

      def display_value
        value.presence || content
      end

      def render?
        value.present? || content.present?
      end

      def has_icon?
        icon.present?
      end

      def has_link?
        href.present?
      end

      def copyable?
        copyable && display_value.present?
      end

      def copy_button_data
        {
          controller: "chalky-copy",
          chalky_copy_value_value: display_value,
          action: "click->chalky-copy#copy"
        }
      end
    end
  end
end
