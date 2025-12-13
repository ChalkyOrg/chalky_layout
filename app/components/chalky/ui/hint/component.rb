# frozen_string_literal: true

module Chalky::Ui
  module Hint
    class Component < ViewComponent::Base
      SIZES = {
        xs: "text-xs",
        sm: "text-sm"
      }.freeze

      attr_reader :text, :size, :icon

      def initialize(text: nil, size: :xs, icon: nil)
        super()
        @text = text
        @size = size.to_sym
        @icon = icon
      end

      def hint_classes
        [
          SIZES.fetch(size, SIZES[:xs]),
          "text-gray-500 mt-1"
        ].join(" ")
      end

      def render?
        text.present? || content.present?
      end
    end
  end
end
