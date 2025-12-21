# frozen_string_literal: true

module Chalky::Page
  module Body
    class Component < ViewComponent::Base
      renders_one :pagination

      attr_reader :css_classes, :spacing_classes, :full_width

      def initialize(css_classes: "", spacing: "py-6", full_width: false)
        super()
        @css_classes = css_classes
        @spacing_classes = spacing
        @full_width = full_width
      end

      def content_classes
        base_classes = "bg-chalky-surface-secondary"
        [base_classes, spacing_classes, css_classes].compact.join(" ")
      end

      def container_classes
        return "" if full_width

        "mx-auto max-w-7xl px-3 md:px-8"
      end

      def pagination?
        pagination.present?
      end
    end
  end
end
