# frozen_string_literal: true

module Chalky::Page
  module Actions
    class Component < ViewComponent::Base
      attr_reader :layout, :spacing_classes

      def initialize(layout: :right, spacing: "")
        super()
        @layout = layout
        @spacing_classes = spacing
      end

      def actions_classes
        base_classes = layout_classes
        [base_classes, spacing_classes].compact.join(" ")
      end

      private

      def layout_classes
        case layout
        when :right
          "flex justify-end items-center gap-2"
        when :left
          "flex justify-start items-center gap-2"
        when :center
          "flex justify-center items-center gap-2"
        else
          "flex items-center gap-2"
        end
      end
    end
  end
end
