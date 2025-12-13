# frozen_string_literal: true

module Chalky::Page
  module Container
    class Component < ViewComponent::Base
      attr_reader :css_classes, :data_attributes

      def initialize(css_classes: "", data_attributes: {})
        super()
        @css_classes = css_classes
        @data_attributes = data_attributes
      end

      def container_classes
        base_classes = "min-h-screen"
        [base_classes, css_classes].compact.join(" ")
      end

      def container_data
        data_attributes
      end
    end
  end
end
