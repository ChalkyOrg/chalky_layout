# frozen_string_literal: true

module Chalky::Ui
  module Alert
    class Component < ViewComponent::Base
      VARIANTS = {
        info: {
          container: "bg-blue-50 border-blue-400 text-blue-800",
          icon: "fa-solid fa-circle-info",
          icon_color: "text-blue-400"
        },
        success: {
          container: "bg-green-50 border-green-400 text-green-800",
          icon: "fa-solid fa-circle-check",
          icon_color: "text-green-400"
        },
        warning: {
          container: "bg-yellow-50 border-yellow-400 text-yellow-800",
          icon: "fa-solid fa-triangle-exclamation",
          icon_color: "text-yellow-400"
        },
        error: {
          container: "bg-red-50 border-red-400 text-red-800",
          icon: "fa-solid fa-circle-xmark",
          icon_color: "text-red-400"
        }
      }.freeze

      STYLES = {
        default: "border rounded-lg p-4",
        left_border: "border-l-4 rounded p-4"
      }.freeze

      attr_reader :title, :message, :variant, :style, :icon, :dismissible

      def initialize(message: nil, title: nil, variant: :info, style: :default, icon: nil, dismissible: false)
        super()
        @title = title
        @message = message
        @variant = variant.to_sym
        @style = style.to_sym
        @icon = icon
        @dismissible = dismissible
      end

      def container_classes
        config = VARIANTS.fetch(variant, VARIANTS[:info])
        [
          config[:container],
          STYLES.fetch(style, STYLES[:default])
        ].join(" ")
      end

      def icon_class
        return icon if icon.present?

        VARIANTS.dig(variant, :icon)
      end

      def icon_color_class
        VARIANTS.dig(variant, :icon_color)
      end

      def render?
        message.present? || content.present?
      end
    end
  end
end
