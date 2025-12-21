# frozen_string_literal: true

module Chalky::Ui
  module InfoRow
    class Component < ViewComponent::Base
      attr_reader :label, :value, :separator, :bold_value

      def initialize(label:, value: nil, separator: false, bold_value: false)
        super()
        @label = label
        @value = value
        @separator = separator
        @bold_value = bold_value
      end

      def container_classes
        base = "flex items-center justify-between"
        separator ? "#{base} pt-3 mt-3 border-t border-chalky-border" : base
      end

      def label_classes
        base = "text-sm text-chalky-text-tertiary"
        bold_value ? "#{base} font-medium" : base
      end

      def value_classes
        base = "text-sm text-chalky-text-primary"
        bold_value ? "#{base} font-semibold" : base
      end

      def render?
        value.present? || content.present?
      end
    end
  end
end
