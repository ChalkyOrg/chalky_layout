# frozen_string_literal: true

module Chalky::AdminForms
  module FormSection
    class Component < ViewComponent::Base
      attr_reader :css_classes, :data_attributes, :spacing_classes

      def initialize(css_classes: "", data_attributes: {}, spacing: "mb-4 md:mb-8")
        super()
        @css_classes = css_classes
        @data_attributes = data_attributes
        @spacing_classes = spacing
      end

      def section_classes
        base_classes = "bg-chalky-surface rounded-lg md:rounded-xl shadow-sm border border-chalky-border p-3 md:p-6"
        [base_classes, spacing_classes, css_classes].compact.join(" ")
      end

      def section_data
        data_attributes
      end
    end
  end
end
