# frozen_string_literal: true

module Chalky::Ui
  module Alert
    class Component < ViewComponent::Base
      VARIANTS = {
        info: {
          container: "bg-chalky-info-light border-chalky-info-border text-chalky-info-text",
          icon: "fa-solid fa-circle-info",
          icon_color: "text-chalky-info-border"
        },
        success: {
          container: "bg-chalky-success-light border-chalky-success-border text-chalky-success-text",
          icon: "fa-solid fa-circle-check",
          icon_color: "text-chalky-success-border"
        },
        warning: {
          container: "bg-chalky-warning-light border-chalky-warning-border text-chalky-warning-text",
          icon: "fa-solid fa-triangle-exclamation",
          icon_color: "text-chalky-warning-border"
        },
        error: {
          container: "bg-chalky-danger-light border-chalky-danger-border text-chalky-danger-text",
          icon: "fa-solid fa-circle-xmark",
          icon_color: "text-chalky-danger-border"
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
